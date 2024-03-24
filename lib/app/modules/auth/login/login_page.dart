import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';

import '../../../core/widgets/todo_list_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight, minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TodoListField(
                              labelText: 'E-mail',
                              controller: _emailEC,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TodoListField(
                              labelText: 'Senha',
                              controller: _passwordEC,
                              enableSwapObscure: true,
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(onPressed: () {}, child: Text('Esqueceu sua senha?')),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: context.buttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: context.background),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.Google,
                              text: 'Continue com o Google',
                              padding: EdgeInsets.all(5.0),
                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                              onPressed: () {},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Não tem conta?'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/register');
                                  },
                                  child: Text(
                                    'Cadastre-se',
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
