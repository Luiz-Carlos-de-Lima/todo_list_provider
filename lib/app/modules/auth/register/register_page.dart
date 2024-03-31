import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/notifier/default_listerner_notifier.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/widgets/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/widgets/todo_list_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    DefaultListernerNotifier(changeNotifier: context.read<RegisterController>()).lister(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: context.background,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: ClipOval(
            child: Container(
              padding: EdgeInsets.all(8),
              color: context.primaryColor.withAlpha(20),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10.0, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 14.0,
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        shape: Border(bottom: BorderSide(width: 3, color: Colors.grey.withAlpha(80))),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListField(
                    labelText: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('O e-mail é inválido.'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TodoListField(
                    labelText: 'Senha',
                    controller: _passwordEC,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(6, 'A senha deve ter pelo meno 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TodoListField(
                    labelText: 'Confirmar Senha',
                    controller: _confirmPasswordEC,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirmar senha obrigatória'),
                      Validatorless.compare(_passwordEC, 'Confirmar senha deve ser igual a senha'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        final formIsValid = _formKey.currentState?.validate() ?? false;

                        if (formIsValid) {
                          final controller = context.read<RegisterController>();

                          await controller.registerUser(email: _emailEC.text, password: _passwordEC.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Salvar',
                          style: TextStyle(color: context.background),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
