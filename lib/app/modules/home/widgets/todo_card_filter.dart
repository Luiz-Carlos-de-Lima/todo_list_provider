import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints(minHeight: 120, maxWidth: 150),
      decoration: BoxDecoration(
        color: context.primaryColor,
        borderRadius: BorderRadius.circular(
          25.0,
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(.8),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              '10 TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            'HOJE',
            style: context.titleStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              borderRadius: BorderRadius.circular(2.0),
              value: .89,
            ),
          )
        ],
      ),
    );
  }
}
