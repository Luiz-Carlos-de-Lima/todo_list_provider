import 'package:todo_list_provider/app/core/exceptions/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

import '../../../core/notifier/default_change_notifier.dart';

class RegisterController extends DefaultChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService}) : _userService = userService;

  Future<void> registerUser({required String email, required String password}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email: email, password: password);
      if (user != null) {
        success();
      } else {
        setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoader();
      notifyListeners();
    }
  }
}
