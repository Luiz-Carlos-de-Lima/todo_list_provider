import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/core/exceptions/auth_exception.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  const UserRepositoryImpl({required FirebaseAuth firebaseAuth}) : this._firebaseAuth = firebaseAuth;

  @override
  Future<User?> register({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e.code == 'email-already-in-use') {
        final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já utillizado, por favor escolha outro e-mail.');
        } else {
          throw AuthException(message: 'Você se cadastrou no todo-list pelo google, por favor utilize ela pra entrar.');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw AuthException(message: 'Erro ao registrar usuário');
    }
  }

  @override
  Future<User?> login({required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      return user.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e.code == 'user-not-found') {
        throw AuthException(message: 'Usuário não encontrado, Para continuar cadastre-se');
      } else if (e.code == 'too-many-requests') {
        throw AuthException(message: 'Erro ao fazer o login, Verifique e-mail e senha e tente novamente');
      } else {
        throw AuthException(message: 'Erro ao fazer o login');
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw AuthException(message: 'Erro ao fazer o login usuário');
    }
  }

  @override
  Future<void> recoverPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e.code == 'user-not-found') {
        throw AuthException(message: 'Usuário não encontrado, Para continuar cadastre-se');
      } else {
        throw AuthException(message: 'Erro ao tentar fazer a solicitação para trocar a senha.');
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw AuthException(message: 'Erro ao fazer a solicitação.');
    }
  }
}
