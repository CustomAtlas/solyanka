import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/navigation/route_names.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel() {
    authenticated();
    settingsComplete();
  }
  bool isAuthenticated = false;
  bool isSettingsComplete = false;
  void goToNextScreen(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (isAuthenticated && isSettingsComplete) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NavigationRouteNames.mainScreen, (_) => false);
      } else if (isAuthenticated) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NavigationRouteNames.selectCategory, (_) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            NavigationRouteNames.authGoogle, (_) => false);
      }
    });
  }

  Future<void> authenticated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuthenticated = prefs.getBool('auth') ?? false;
  }

  Future<void> settingsComplete() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSettingsComplete = prefs.getBool('settings') ?? false;
  }
}
