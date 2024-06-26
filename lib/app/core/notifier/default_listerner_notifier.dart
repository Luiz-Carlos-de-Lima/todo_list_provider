import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListernerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListernerNotifier({required this.changeNotifier});

  void lister({required BuildContext context, required SuccessVoidCallback successCallback, ErrorVoidCallback? errorCallback}) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno.');
      } else if (changeNotifier.hasSuccessMessage) {
        Messages.of(context).showInfo(changeNotifier.successMessage ?? 'A solicitação foi aceita.');
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(DefaultChangeNotifier notifier, DefaultListernerNotifier listernerInstance);

typedef ErrorVoidCallback = void Function(DefaultChangeNotifier notifier, DefaultListernerNotifier listernerInstance);
