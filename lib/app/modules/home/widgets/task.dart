import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 1,
        ),
      ]),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 1),
          ),
          leading: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
          title: Text(
            'Descricaro da Task',
            style: TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            '20/07/2024',
            style: TextStyle(decoration: true ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}
