import 'package:nested/nested.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_page.dart';

class AuthModule extends TodoListModules {
  static Map<String, WidgetBuilder> get _routers {
    return {
      '/login': (context) => LoginPage(),
      '/register': (context) => RegisterPage(),
    };
  }

  static List<SingleChildWidget>? get _bindings {
    return [
      ChangeNotifierProvider(create: (context) => LoginController(userService: context.read())),
      ChangeNotifierProvider(create: (context) => RegisterController(userService: context.read())),
    ];
  }

  AuthModule() : super(routers: _routers, bindings: _bindings);
}
