import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';

import '../../../core/auth/auth_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Selector<AuthProvider, String>(
              selector: (_, authProvider) => authProvider.user?.displayName ?? 'Não informado',
              builder: (_, name, __) {
                return Text(
                  'E ai, $name!',
                  style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                );
              }),
        )
      ],
    );
  }
}
