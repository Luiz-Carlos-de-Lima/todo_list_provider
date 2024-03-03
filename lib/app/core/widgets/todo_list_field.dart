import 'package:flutter/material.dart';

class TodoListField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool enableSwapObscure;

  const TodoListField({super.key, required this.labelText, this.obscureText = false, this.enableSwapObscure = false});

  @override
  State<TodoListField> createState() => _TodoListFieldState();
}

class _TodoListFieldState extends State<TodoListField> {
  final obscure = ValueNotifier<bool>(false);

  @override
  void initState() {
    obscure.value = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: false,
      obscureText: obscure.value,
      decoration: InputDecoration(
        constraints: BoxConstraints(maxHeight: 60, minHeight: 60),
        hintText: widget.labelText,
        suffixIcon: widget.enableSwapObscure
            ? IconButton(
                onPressed: () {
                  obscure.value = !obscure.value;
                },
                icon: AnimatedBuilder(
                  animation: obscure,
                  builder: (context, _) {
                    return Icon(
                      obscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    );
                  },
                ),
              )
            : null,
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 2),
        ),
      ),
    );
  }
}
