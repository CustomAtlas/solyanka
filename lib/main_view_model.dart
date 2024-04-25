import 'package:flutter/material.dart';
import 'package:solyanka/navigation/route_names.dart';

class MainViewModel extends ChangeNotifier {
  bool editExpertises = false;
  bool light = false;
  var themeMode = ThemeMode.system;

  void changeTheme() {
    light = !light;
    themeMode = light ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void toEditExpertises(BuildContext context) {
    editExpertises = true;
    Navigator.of(context).pushNamed(NavigationRouteNames.chooseExpertises);
    notifyListeners();
  }
}
