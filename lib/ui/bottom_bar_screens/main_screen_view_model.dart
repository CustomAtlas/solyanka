import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/domain/api_clients/firebase/firebase.dart';
import 'package:solyanka/domain/api_clients/jobs/http.dart';
import 'package:solyanka/domain/entities/vacancy_object.dart';
import 'package:solyanka/navigation/route_names.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MainScreenViewModel extends ChangeNotifier {
  final MyAuth myAuth;
  MainScreenViewModel({required this.myAuth}) {
    changeMeeting();
    getProfileInfo();
    getExpertisesFields();
    searchController.addListener(() {
      notifyListeners();
    });
    searchJobController.addListener(() {
      getSearchVacancies(searchJobController.text);
      notifyListeners();
    });
    getVacancies();
    ytCcontroller.addListener(() {});
  }

  ///////////////////
  // main/home screen fields
  ///////////////////
  var currentIndex = 0;
  final currentTime = TimeOfDay.now().hour;
  String meeting = '';
  String name = '';
  Image image = const Image(image: AppImages.profileIcon);
  final searchController = TextEditingController();
  var favoriteVacancies = <VacancyObject>[];

  void changeMeeting() {
    if (currentTime >= 5 && currentTime < 12) meeting = 'Good morning!';
    if (currentTime >= 12 && currentTime < 18) meeting = 'Good afternoon!';
    if (currentTime >= 18 && currentTime < 22) meeting = 'Good evening!';
    if (currentTime >= 22 && currentTime < 5) meeting = 'Have a good night!';
  }

  Future<void> getProfileInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name')!;
    birth = prefs.getString('birth')!;
    number = prefs.getString('number')!;
    gender = prefs.getString('gender')!;
    email = prefs.getString('email')!;
    isSelectedJob = prefs.getBool('job_category')!;
    var imageName = prefs.getString('image')!;

    if (imageName.contains('bmo')) {
      image = const Image(image: AppImages.bmo);
    } else if (imageName.contains('finn')) {
      image = const Image(image: AppImages.finn);
    } else if (imageName.contains('jake')) {
      image = const Image(image: AppImages.jake);
    } else if (imageName.contains('marcy')) {
      image = const Image(image: AppImages.marcy);
    } else {
      image = const Image(image: AppImages.princess);
    }
    notifyListeners();
  }

  void openVacanciesPage() {
    currentIndex = 2;
    notifyListeners();
  }

  void openCurrentPage(int value) {
    currentIndex = value;
    notifyListeners();
  }

  void goToVacancyInfo(BuildContext context, int i) {
    Navigator.pushNamed(context, NavigationRouteNames.vacancyInfo,
        arguments: vacancies[i]);
  }

  void saveVacancy(String id) {
    for (var v in vacancies) {
      if (v.vacancy.id == id && !favoriteVacancies.contains(v)) {
        favoriteVacancies.add(v);
        notifyListeners();
      } else if (v.vacancy.id == id && favoriteVacancies.contains(v)) {
        favoriteVacancies.remove(v);
        notifyListeners();
      }
    }
  }

  void explore() {
    currentIndex = 1;
    notifyListeners();
  }

  ///////////////////
  // click here screen fields
  ///////////////////
  final mathController = TextEditingController();
  String? errorText;
  final ytCcontroller = YoutubePlayerController(
      initialVideoId: 'fPxgZn9HdWc',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: true));

  Never crashMyApp() {
    throw 'Why!?';
  }

  void checkAnswer(BuildContext context) {
    if (mathController.text.trim() == '-6') {
      errorText = null;
      Navigator.pop(context);
    } else {
      errorText = 'Nope';
    }
  }

  ///////////////////
  // jobs screen fields
  ///////////////////
  final myHttp = MyHttpClient();

  var vacancies = <VacancyObject>[];
  int currentPage = 1;
  int currentSearchPage = 1;
  String httpError = '';
  final searchJobController = TextEditingController();
  final pageController = PageController();
  Timer? searchTimer;

  Future<void> getVacancies() async {
    try {
      httpError = '';
      vacancies.addAll(await myHttp.getVacancyObjects(1));
      notifyListeners();
    } catch (e) {
      httpError = 'Something went wrong';
      notifyListeners();
    }
  }

  Future<void> getNextPage(int index) async {
    if (index < vacancies.length - 1) return;
    currentPage += 1;
    try {
      httpError = '';
      vacancies.addAll(await myHttp.getVacancyObjects(currentPage));
      notifyListeners();
    } catch (e) {
      httpError = 'Something went wrong';
      notifyListeners();
    }
  }

  Future<void> getNextSearchPage(String search, int index) async {
    if (index < vacancies.length - 1) return;
    currentPage += 1;
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(milliseconds: 700), () async {
      try {
        httpError = '';
        vacancies
            .addAll(await myHttp.getSearchVacancies(currentSearchPage, search));
        notifyListeners();
      } catch (e) {
        httpError = 'Something went wrong';
        notifyListeners();
      }
    });
  }

  Future<void> getSearchVacancies(String search) async {
    currentSearchPage += 1;
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(milliseconds: 700), () async {
      try {
        httpError = '';
        vacancies.clear();
        vacancies
            .addAll(await myHttp.getSearchVacancies(currentSearchPage, search));
        notifyListeners();
      } catch (e) {
        httpError = 'Something went wrong';
        notifyListeners();
      }
    });
  }

  ///////////////////
  // profile settings screen fields
  ///////////////////
  String birth = '';
  String email = '';
  String number = '';
  String gender = '';
  bool isSelectedJob = true;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  String? numberError;
  String? nameError;
  String? emailError;

  var choosedFields = <String>[];

  Future<void> getExpertisesFields() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final it = prefs.getBool('it') ?? false;
    final arts = prefs.getBool('arts') ?? false;
    final safety = prefs.getBool('safety') ?? false;
    final pr = prefs.getBool('pr') ?? false;
    final med = prefs.getBool('med') ?? false;
    final sci = prefs.getBool('sci') ?? false;
    final sales = prefs.getBool('sales') ?? false;
    final constr = prefs.getBool('constr') ?? false;
    final fin = prefs.getBool('fin') ?? false;

    if (it) choosedFields.add('IT');
    if (arts) choosedFields.add('Arts, entertainment, media');
    if (safety) choosedFields.add('Safety');
    if (pr) choosedFields.add('Marketing, advertising, PR');
    if (med) choosedFields.add('Medicine, pharmaceuticals');
    if (sci) choosedFields.add('Science, education');
    if (sales) choosedFields.add('Sales, customer service');
    if (constr) choosedFields.add('Construction, real estate');
    if (fin) choosedFields.add('Finance, accounting');
  }

  Future<void> changeJobCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSelectedJob = !isSelectedJob;
    prefs.setBool('job_category', isSelectedJob);
    notifyListeners();
  }

  void changeName(BuildContext context) {
    if (nameController.text.trim().isEmpty) {
      nameError = 'Field is empty';
      notifyListeners();
      return;
    }
    nameError = null;
    notifyListeners();
    name = nameController.text;
    notifyListeners();
    Navigator.pop(context);
    saveName();
  }

  Future<void> saveName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', nameController.text);
  }

  Future<void> myDatePicker(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      final initYear = int.parse(birth.substring(10));
      final initMonth = int.parse(birth.substring(5, 8));
      final initDay = int.parse(birth.substring(0, 3));
      await showDatePicker(
        context: context,
        firstDate: DateTime(1950, 1, 1),
        lastDate: DateTime(2020, 1, 1),
        initialDate: DateTime(initYear, initDay, initMonth),
      ).then((selectedDate) {
        if (selectedDate != null) {
          final month = selectedDate.month < 10
              ? '0${selectedDate.month}'
              : '${selectedDate.month}';
          final day = selectedDate.day < 10
              ? '0${selectedDate.day}'
              : '${selectedDate.day}';
          birth = '$month / $day / ${selectedDate.year}';
          prefs.setString('birth', birth);
        }
      });
    }
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

  void changeEmail(BuildContext context) {
    if (emailController.text.length < 4 ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      emailError = 'Invalid email';
      notifyListeners();
      return;
    }
    emailError = null;
    email = emailController.text;
    notifyListeners();
    Navigator.pop(context);
    saveEmail();
  }

  Future<void> saveEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
  }

  void changeNumber(BuildContext context) {
    if (numberController.text.length < 13) {
      numberError = 'Invalid number';
      notifyListeners();
      return;
    }
    numberError = null;
    number = numberController.text;
    notifyListeners();
    Navigator.pop(context);
    saveNumber();
  }

  Future<void> saveNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('number', numberController.text);
  }

  Future<void> changeGender() async {
    if (gender == 'Male') {
      gender = 'Female';
      notifyListeners();
    } else {
      gender = 'Male';
      notifyListeners();
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);
  }

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

  Future<void> saveImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('image', image.image.toString().substring(46, 54));
  }

  void goToHelpChat(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationRouteNames.helpChat);
  }

  Future<void> signOut(BuildContext context) async {
    myAuth.signOut();
    if (GoogleSignIn().currentUser != null) {
      myAuth.googleSignOut();
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);
    prefs.setBool('settings', false);
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          NavigationRouteNames.authCredentials, (_) => false);
    }
  }

  @override
  void dispose() {
    mathController.dispose();
    nameController.dispose();
    numberController.dispose();
    searchController.removeListener(() {});
    searchController.dispose();
    searchJobController.removeListener(() {});
    searchJobController.dispose();
    ytCcontroller.removeListener(() {});
    ytCcontroller.dispose();
    super.dispose();
  }
}
