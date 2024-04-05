import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

import 'task.dart';

class HomeTasks extends StatefulWidget {
  const HomeTasks({super.key});

  @override
  State<HomeTasks> createState() => _HomeTasksState();
}

class _HomeTasksState extends State<HomeTasks> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Text(
          'TASK\'S DE HOJE',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Column(
          children: [
            Task(),
            Task(),
            Task(),
            Task(),
          ],
        )
      ],
    ));
  }
}
