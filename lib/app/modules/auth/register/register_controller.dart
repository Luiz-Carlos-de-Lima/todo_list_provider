import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/exceptions/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService}) : _userService = userService;

  Future<void> registerUser({required String email, required String password}) async {
    try {
      error = null;
      success = false;
      final user = await _userService.register(email: email, password: password);

      if (user != null) {
        success = true;
      } else {
        error = 'Erro ao registrar usuário';
      }
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }
}
