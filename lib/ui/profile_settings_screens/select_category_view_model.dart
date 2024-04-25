import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/navigation/route_names.dart';

class SelectCategoryViewModel extends ChangeNotifier {
  bool isSelectedJob = true;

  void selectJob() {
    if (isSelectedJob) return;
    isSelectedJob = true;
    notifyListeners();
  }

  void selectEmployee() {
    if (!isSelectedJob) return;
    isSelectedJob = false;
    notifyListeners();
  }

  Future<void> saveCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('job_category', isSelectedJob);
  }

  void goToChooseExpertises(BuildContext context) {
    saveCategory();
    Navigator.of(context).pushNamed(NavigationRouteNames.chooseExpertises);
  }
}
