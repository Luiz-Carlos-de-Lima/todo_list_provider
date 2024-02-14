// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModules {
  Map<String, WidgetBuilder> _routers;
  List<SingleChildWidget>? _bindings;

  TodoListModules({
    required Map<String, WidgetBuilder> routers,
    List<SingleChildWidget>? bindings,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, value) => MapEntry(
        key,
        (context) => TodoListPage(
          page: value,
          bindings: _bindings,
        ),
      ),
    );
  }
}
