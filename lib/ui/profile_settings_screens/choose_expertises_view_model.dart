import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/navigation/route_names.dart';

class ChooseExpertisesViewModel extends ChangeNotifier {
  ChooseExpertisesViewModel() {
    getValues();
  }

  int c = 0;
  var errorMessage = '';

  // Honestly i'm also scared to see this
  // I've tried to do it by List or Map but i haven't succeeded yet

  bool it = false;
  bool arts = false;
  bool safety = false;
  bool pr = false;
  bool med = false;
  bool sci = false;
  bool sales = false;
  bool constr = false;
  bool fin = false;

  Future<void> getValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    it = prefs.getBool('it') ?? false;
    arts = prefs.getBool('arts') ?? false;
    safety = prefs.getBool('safety') ?? false;
    pr = prefs.getBool('pr') ?? false;
    med = prefs.getBool('med') ?? false;
    sci = prefs.getBool('sci') ?? false;
    sales = prefs.getBool('sales') ?? false;
    constr = prefs.getBool('constr') ?? false;
    fin = prefs.getBool('fin') ?? false;
    c = prefs.getInt('c') ?? 0;
    notifyListeners();
  }

  // And tried this by another function but it doesn't worked

  Future<void> toggleMarked(String expertise) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (expertise) {
      case 'IT':
        if (it) {
          c--;
          it = false;
          prefs.setBool('it', false);
        } else {
          if (c > 4) break;
          c++;
          it = true;
          prefs.setBool('it', true);
        }
        notifyListeners();
      case 'Arts, entertainment, media':
        if (arts) {
          c--;
          arts = false;
          prefs.setBool('arts', false);
        } else {
          if (c > 4) break;
          c++;
          arts = true;
          prefs.setBool('arts', true);
        }
        notifyListeners();
      case 'Safety':
        if (safety) {
          c--;
          safety = false;
          prefs.setBool('safety', false);
        } else {
          if (c > 4) break;
          c++;
          safety = true;
          prefs.setBool('safety', true);
        }
        notifyListeners();
      case 'Marketing, advertising, PR':
        if (pr) {
          c--;
          pr = false;
          prefs.setBool('pr', false);
        } else {
          if (c > 4) break;
          c++;
          pr = true;
          prefs.setBool('pr', true);
        }
        notifyListeners();
      case 'Medicine, pharmaceuticals':
        if (med) {
          c--;
          med = false;
          prefs.setBool('med', false);
        } else {
          if (c > 4) break;
          c++;
          med = true;
          prefs.setBool('med', true);
        }
        notifyListeners();
      case 'Science, education':
        if (sci) {
          c--;
          sci = false;
          prefs.setBool('sci', false);
        } else {
          if (c > 4) break;
          c++;
          sci = true;
          prefs.setBool('sci', true);
        }
        notifyListeners();
      case 'Sales, customer service':
        if (sales) {
          c--;
          sales = false;
          prefs.setBool('sales', false);
        } else {
          if (c > 4) break;
          c++;
          sales = true;
          prefs.setBool('sales', true);
        }
        notifyListeners();
      case 'Construction, real estate':
        if (constr) {
          c--;
          constr = false;
          prefs.setBool('constr', false);
        } else {
          if (c > 4) break;
          c++;
          constr = true;
          prefs.setBool('constr', true);
        }
        notifyListeners();
      case 'Finance, accounting':
        if (fin) {
          c--;
          fin = false;
          prefs.setBool('constr', false);
        } else {
          if (c > 4) break;
          c++;
          fin = true;
          prefs.setBool('constr', true);
        }
        notifyListeners();
    }
    prefs.setInt('c', c);
    if (c > 0) {
      errorMessage = '';
      notifyListeners();
    }
  }

  void goToProfileSettings(BuildContext context) {
    if (c == 0) {
      errorMessage = 'Choose expertises';
      notifyListeners();
      return;
    }
    Navigator.of(context).pushNamed(NavigationRouteNames.profileSettings);
  }

  void backToProfile(BuildContext context) {
    if (c == 0) {
      errorMessage = 'Choose expertises';
      notifyListeners();
      return;
    }
    Navigator.of(context).pushReplacementNamed(NavigationRouteNames.mainScreen);
    notifyListeners();
  }
}
