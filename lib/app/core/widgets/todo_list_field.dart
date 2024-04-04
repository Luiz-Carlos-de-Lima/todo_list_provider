import 'package:flutter/material.dart';

class TodoListField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool enableSwapObscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const TodoListField({super.key, required this.labelText, this.obscureText = false, this.enableSwapObscure = false, required this.controller, this.validator, this.focusNode});

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
    return AnimatedBuilder(
        animation: obscure,
        builder: (context, _) {
          return SizedBox(
            child: TextFormField(
              expands: false,
              controller: widget.controller,
              obscureText: obscure.value,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                isCollapsed: true,
                isDense: true,
                hintText: widget.labelText,
                suffixIcon: widget.enableSwapObscure
                    ? IconButton(
                        onPressed: () {
                          obscure.value = !obscure.value;
                        },
                        icon: Icon(
                          obscure.value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
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
              validator: widget.validator,
            ),
          );
        });
  }
}
