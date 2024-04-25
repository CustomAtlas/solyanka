import 'package:flutter/material.dart';

class CredentialsAuthViewModel extends ChangeNotifier {
  CredentialsAuthViewModel() {
    eController.addListener(() => showEmailHelperText());
    pController.addListener(() => showPasswordHelperText());
  }

  final eController = TextEditingController();
  final pController = TextEditingController();
  var isEmailFieldEmty = true;
  var isPasswordFieldEmty = true;
  var isSuccess = false;

  void showEmailHelperText() {
    if (eController.text.isNotEmpty) {
      isEmailFieldEmty = false;
      notifyListeners();
    } else {
      isEmailFieldEmty = true;
      notifyListeners();
    }
  }

  void showPasswordHelperText() {
    if (pController.text.isNotEmpty) {
      isPasswordFieldEmty = false;
      notifyListeners();
    } else {
      isPasswordFieldEmty = true;
      notifyListeners();
    }
  }

  void showNotification(BuildContext context) {
    isSuccess = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      isSuccess = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    eController.removeListener(() {});
    pController.removeListener(() {});
    eController.dispose();
    pController.dispose();
    super.dispose();
  }
}
