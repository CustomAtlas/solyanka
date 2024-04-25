import 'package:flutter/material.dart';
import 'package:solyanka/my_app.dart';
import 'package:solyanka/navigation/route_names.dart';

abstract class ScreenFactory {
  Widget makeLoaderSplash();
  Widget makeAuthGoogle();
  Widget makeAuthCredentials();
  Widget makeSelectCategory();
  Widget makeChooseExpertises();
  Widget makeProfileSettings();
  Widget makeMainScreen();
  Widget makeVacancyInfo();
  Widget makeHelpChat();
}

class Navigation implements MyAppNavigation {
  final ScreenFactory screenFactory;

  const Navigation(this.screenFactory);

  @override
  Map<String, Widget Function(BuildContext)> get routes => {
        NavigationRouteNames.loaderSplashScreen: (_) =>
            screenFactory.makeLoaderSplash(),
        NavigationRouteNames.authGoogle: (_) => screenFactory.makeAuthGoogle(),
        NavigationRouteNames.authCredentials: (_) =>
            screenFactory.makeAuthCredentials(),
        NavigationRouteNames.selectCategory: (_) =>
            screenFactory.makeSelectCategory(),
        NavigationRouteNames.chooseExpertises: (_) =>
            screenFactory.makeChooseExpertises(),
        NavigationRouteNames.profileSettings: (_) =>
            screenFactory.makeProfileSettings(),
        NavigationRouteNames.mainScreen: (_) => screenFactory.makeMainScreen(),
        NavigationRouteNames.vacancyInfo: (_) =>
            screenFactory.makeVacancyInfo(),
        NavigationRouteNames.helpChat: (_) => screenFactory.makeHelpChat(),
      };
}
