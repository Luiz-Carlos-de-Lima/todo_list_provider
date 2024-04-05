import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

import '../../../core/auth/auth_provider.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final editName = ValueNotifier<String>('');

  @override
  void dispose() {
    editName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ?? '';
                  },
                  builder: (_, img, __) => CircleAvatar(
                    backgroundImage: NetworkImage(img),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Nome não informado';
                    },
                    builder: (_, nome, __) => Text(nome, style: context.textTheme.subtitle2),
                  ),
                )),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              editName.value = '';
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Informe um novo nome'),
                  content: TextField(autofocus: true, onChanged: (newName) => editName.value = newName),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(color: context.errorColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (editName.value.isEmpty) {
                          Messages.of(context).showError('O campo não pode estar vazio');
                          return;
                        }
                        Navigator.of(context).pop();
                        Loader.show(context);
                        await context.read<UserService>().updateDisplayName(name: editName.value);
                        Loader.hide();
                      },
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: context.primaryColor),
                      ),
                    ),
                  ],
                ),
              );
            },
            leading: Icon(Icons.edit),
            title: Text('Alterar Nome', style: context.textTheme.subtitle2),
          ),
          ListTile(
            onTap: () {
              context.read<AuthProvider>().logout();
            },
            leading: Icon(Icons.exit_to_app_rounded),
            title: Text('Sair', style: context.textTheme.subtitle2),
          ),
        ],
      ),
    );
  }
}
