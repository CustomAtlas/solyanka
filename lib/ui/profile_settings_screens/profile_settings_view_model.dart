import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/navigation/route_names.dart';
import 'package:solyanka/resources/app_images.dart';

class ProfileSettingsViewModel extends ChangeNotifier {
  ProfileSettingsViewModel() {
    nameController.addListener(() => showNameHelperText());
    dateController.addListener(() => showDateHelperText());
    numberController.addListener(() => showNumberHelperText());
  }

  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final numberController = TextEditingController();
  bool isNameFieldEmpty = true;
  bool isDateFieldEmpty = true;
  bool isnumberFieldEmpty = true;
  String? dateErrorText;
  bool gender = true;
  bool genderisEmpty = true;
  String fieldsError = '';
  String selectedGender = '';

  Image image = const Image(image: AppImages.profileIcon);

  void setProfileImage(String pic, BuildContext context) {
    switch (pic) {
      case 'bmo':
        image = const Image(image: AppImages.bmo);
      case 'finn':
        image = const Image(image: AppImages.finn);
      case 'jake':
        image = const Image(image: AppImages.jake);
      case 'marcy':
        image = const Image(image: AppImages.marcy);
      case 'princess':
        image = const Image(image: AppImages.princess);
    }
    notifyListeners();
    Navigator.pop(context);
  }

  void showNameHelperText() {
    if (nameController.text.isNotEmpty) {
      isNameFieldEmpty = false;
      notifyListeners();
    } else {
      isNameFieldEmpty = true;
      notifyListeners();
    }
  }

  void showDateHelperText() {
    if (dateController.text.isNotEmpty) {
      isDateFieldEmpty = false;
      notifyListeners();
    } else {
      isDateFieldEmpty = true;
      notifyListeners();
    }
    fieldsError = '';
    notifyListeners();
  }

  void showNumberHelperText() {
    if (numberController.text.isNotEmpty) {
      isnumberFieldEmpty = false;
      notifyListeners();
    } else {
      isnumberFieldEmpty = true;
      notifyListeners();
    }
    fieldsError = '';
    notifyListeners();
  }

  TextEditingValue dateFormatter(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final numb = newValue.text.split('');
    var chars = <String>[];
    dateErrorText = null;

    if (numb.length == 3) {
      final month = numb.getRange(0, 2).join();
      if (int.parse(month) > 12 || int.parse(month) == 0) {
        dateErrorText = 'Month can be only from 1 to 12 or use 0 at start';
        notifyListeners();
        return oldValue;
      }
    }
    if (numb.length == 5) {
      final day = numb.getRange(2, 4).join();
      if (int.parse(day) > 31 || int.parse(day) == 0) {
        dateErrorText = 'Day can be only from 1 to 31 or use 0 at start';
        notifyListeners();
        return oldValue;
      }
    }
    if (numb.length == 8) {
      final year = numb.getRange(4, 8).join();
      if (int.parse(year) > 2020 || int.parse(year) < 1950) {
        dateErrorText = 'Year can be only from 1950 to 2020';
        notifyListeners();
        return oldValue;
      }
    }

    for (var i = 0; i < numb.length; i++) {
      if (i == 2 || i == 4) {
        chars.add(' / ');
        chars.add(numb[i]);
      } else {
        chars.add(numb[i]);
      }
    }
    final finalNumb = chars.join();
    if (finalNumb.length > 14) return oldValue;
    return TextEditingValue(text: finalNumb);
  }

  Future<void> myDatePicker(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(1950, 1, 1),
      lastDate: DateTime(2020, 1, 1),
      initialDate: DateTime(2001, 5, 23),
    ).then((selectedDate) {
      if (selectedDate != null) {
        final month = selectedDate.month < 10
            ? '0${selectedDate.month}'
            : '${selectedDate.month}';
        final day = selectedDate.day < 10
            ? '0${selectedDate.day}'
            : '${selectedDate.day}';
        dateController.text = '$month / $day / ${selectedDate.year}';
      }
    });
    dateErrorText = null;
    fieldsError = '';
    notifyListeners();
  }

  TextEditingValue numbFormatter(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final numb = newValue.text.split('');
    var chars = <String>[];

    final initialScpecialSymbolCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'[\d]+'), '')
        .length;
    final cursorPosition =
        newValue.selection.start - initialScpecialSymbolCount;
    var finalCursorPosition = cursorPosition;

    if (oldValue.selection.textBefore(oldValue.text).endsWith(' ')) {
      numb.removeAt(cursorPosition - 1);
      finalCursorPosition -= 2;
    }

    for (var i = 0; i < numb.length; i++) {
      if (i == 3 || i == 6 || i == 8) {
        chars.add(' ');
        chars.add(numb[i]);
        if (i <= cursorPosition) {
          finalCursorPosition += 1;
        }
      } else {
        chars.add(numb[i]);
      }
    }
    final finalNumb = chars.join();
    if (finalNumb.length > 13) return oldValue;
    return TextEditingValue(
      text: finalNumb,
      selection: TextSelection.collapsed(offset: finalCursorPosition),
    );
  }

  void showGender(String? value) {
    gender = false;
    genderisEmpty = false;
    fieldsError = '';
    selectedGender = value!;
    notifyListeners();
  }

  void goToMainScreen(BuildContext context) {
    if (nameController.text.isEmpty ||
        dateController.text.isEmpty ||
        numberController.text.isEmpty ||
        genderisEmpty) {
      fieldsError = 'One or more fields are empty';
      notifyListeners();
      return;
    }
    if (dateController.text.length < 14) {
      fieldsError = 'Invalid date';
      notifyListeners();
      return;
    }
    if (numberController.text.length < 13) {
      fieldsError = 'Invalid number';
      notifyListeners();
      return;
    }

    saveFields();

    Navigator.of(context).pushNamedAndRemoveUntil(
        NavigationRouteNames.mainScreen, (route) => false);
  }

  Future<void> saveFields() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
    prefs.setString('birth', dateController.text);
    prefs.setString('number', numberController.text);
    prefs.setString('gender', selectedGender);
    prefs.setString('image', image.image.toString().substring(46, 54));
    prefs.setBool('settings', true);
  }

  @override
  void dispose() {
    nameController.removeListener(() {});
    dateController.removeListener(() {});
    numberController.removeListener(() {});
    nameController.dispose();
    dateController.dispose();
    numberController.dispose();
    super.dispose();
  }
}
