import 'package:flutter/material.dart';

import '../../core/widgets/todo_list_logo.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TodoListLogo(),
          const SizedBox(
            height: 50.0,
          ),
          SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ))
        ],
      )),
    );
  }
}
