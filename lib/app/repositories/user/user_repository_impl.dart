import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('google')) {
        throw AuthException(message: 'Cadastrou realizado pelo google, não pode ser resetado a senha');
      } else {
        throw AuthException(message: 'E-mail não cadastrado.');
      }
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e.code == 'user-not-found') {
        throw AuthException(message: 'Usuário não encontrado, Para continuar cadastre-se');
      } else {
        throw AuthException(message: 'Erro ao tentar fazer a solicitação para trocar a senha.');
      }
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googleSignIn = await GoogleSignIn();
      final googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(message: 'Você já se cadastrou no todo list usando o cadastro com e-mail e senha.');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          final userCredential = await _firebaseAuth.signInWithCredential(firebaseCredential);
          return userCredential.user;
        }
      } else {
        throw AuthException(message: 'Ação cancelada.');
      }
    } on FirebaseAuthException catch (e, s) {
      log(e.toString());
      log(s.toString());

      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(message: 'Login inválido, você se cadastrou no todo list com os seguintes provedores. ${loginMethods?.join(',')}');
      } else {
        throw AuthException(message: 'Erro ao realizar login.');
      }
    }
  }
}
