import 'dart:developer';

import 'package:todo_list_provider/app/core/exceptions/auth_exception.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService userService;

  LoginController({required this.userService});

  Future<void> login({required String email, required String password}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await userService.login(email: email, password: password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao tentar fazer o login');
      }
    } on AuthException catch (e, s) {
      log(e.message.toString());
      log(s.toString());
      setError(e.message);
    } catch (e) {
      log('Ocorreu um erro não esperado ao tentar fazer o login.');
    } finally {
      hideLoader();
      notifyListeners();
    }
  }

  Future<void> recoverPassword({required String email}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      await userService.recoverPassword(email: email);
      setSuccessMessage('A solicitação de recuperação de senha foi enviada, verifique o seu e-mail.');
    } on AuthException catch (e, s) {
      log(e.message.toString());
      log(s.toString());
      setError(e.message);
    } catch (e) {
      log('Ocorreu um erro não esperado ao tentar fazer o login.');
    } finally {
      hideLoader();
      notifyListeners();
    }
  }

  Future<void> loginGoogle() async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await userService.googleLogin();
      if (user != null) {
        success();
      } else {
        setError('Erro ao tentar fazer o login');
      }
    } on AuthException catch (e, s) {
      log(e.message.toString());
      log(s.toString());
      setError(e.message);
    } catch (e) {
      log('Ocorreu um erro não esperado ao tentar fazer o login.');
    } finally {
      hideLoader();
      notifyListeners();
    }
  }
}
