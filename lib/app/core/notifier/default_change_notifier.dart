import 'package:flutter/material.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  String? _successMessage;
  bool _success = false;

  bool get loading => _loading;
  String? get error => _error;
  String? get successMessage => _successMessage;
  bool get hasError => _error != null;
  bool get hasSuccessMessage => _successMessage != null;
  bool get isSuccess => _success;

  void showLoading() => _loading = true;
  void success() => _success = true;
  void setError(String? error) => _error = error;
  void setSuccessMessage(String? successMessage) => _successMessage = successMessage;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void hideLoader() {
    _loading = false;
  }

  void resetState() {
    setError(null);
    setSuccessMessage(null);
    _success = false;
  }
}
