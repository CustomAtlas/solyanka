import 'package:flutter/material.dart';
import 'package:solyanka/navigation/route_names.dart';

class GoogleAuthViewModel extends ChangeNotifier {
  void goToCredentialsAuth(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationRouteNames.authCredentials);
  }
}
