import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/constants/routes.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModules {
  static Map<String, WidgetBuilder> get _routers {
    return {
      Routers.home: (context) => HomePage(),
    };
  }

  static List<SingleChildWidget>? get _bindings {
    return [
      ChangeNotifierProvider(create: (context) => HomeController()),
    ];
  }

  HomeModule() : super(routers: _routers, bindings: _bindings);
}
