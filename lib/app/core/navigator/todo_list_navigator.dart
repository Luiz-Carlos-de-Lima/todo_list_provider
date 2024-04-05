import 'package:flutter/material.dart';

sealed class TodoListNavigator {
  TodoListNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get to => navigatorKey.currentState!;
}
