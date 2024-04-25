import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/domain/api_clients/firebase/firebase.dart';
import 'package:solyanka/main.dart';
import 'package:solyanka/main_view_model.dart';
import 'package:solyanka/my_app.dart';
import 'package:solyanka/navigation/navigation.dart';
import 'package:solyanka/ui/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:solyanka/ui/bottom_bar_screens/help_chat/chat_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/help_chat/chat_screen_view_model.dart';
import 'package:solyanka/ui/bottom_bar_screens/home_job_cubit/job_cubit.dart';
import 'package:solyanka/ui/bottom_bar_screens/vacancy_info_screen.dart';
import 'package:solyanka/ui/splash_screen/splash_screen.dart';
import 'package:solyanka/ui/splash_screen/splash_view_model.dart';
import 'package:solyanka/ui/auth_screens/credentials_auth_view_model.dart';
import 'package:solyanka/ui/auth_screens/google_auth_view_model.dart';
import 'package:solyanka/ui/auth_screens/credentials_auth_screen.dart';
import 'package:solyanka/ui/auth_screens/google_auth_screen.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen_view_model.dart';
import 'package:solyanka/ui/bottom_bar_screens/main_screen.dart';
import 'package:solyanka/ui/profile_settings_screens/choose_expertises_screen.dart';
import 'package:solyanka/ui/profile_settings_screens/choose_expertises_view_model.dart';
import 'package:solyanka/ui/profile_settings_screens/profile_settings_screen.dart';
import 'package:solyanka/ui/profile_settings_screens/profile_settings_view_model.dart';
import 'package:solyanka/ui/profile_settings_screens/select_category_screen.dart';
import 'package:solyanka/ui/profile_settings_screens/select_category_view_model.dart';
import 'package:provider/provider.dart';

AppFactory makeAppFactory() => _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  final _diContainer = _DIContainer();

  _AppFactoryDefault();

  @override
  Widget makeApp() => ChangeNotifierProvider(
        create: (context) => _diContainer._makeMainViewModel(),
        lazy: false,
        child: MyApp(navigation: _diContainer._makeMyAppNavigation()),
      );
}

class _DIContainer {
  final myAuth = MyAuth();
  _DIContainer();

  ScreenFactory _makeScreenFactory() => _ScreenFactoryDefault(this);
  MyAppNavigation _makeMyAppNavigation() => Navigation(_makeScreenFactory());

  MainViewModel _makeMainViewModel() => MainViewModel();

  SplashViewModel _makeSplashViewModel() => SplashViewModel();

  GoogleAuthViewModel _makeGoogleAuthViewModel() => GoogleAuthViewModel();
  CredentialsAuthViewModel _makeCredentialsAuthViewModel() =>
      CredentialsAuthViewModel();
  AuthBloc _makeAuthBloc() => AuthBloc();

  SelectCategoryViewModel _makeSelectCategoryViewModel() =>
      SelectCategoryViewModel();
  ChooseExpertisesViewModel _makeChooseExpertisesViewModel() =>
      ChooseExpertisesViewModel();
  ProfileSettingsViewModel _makeProfileSettingsViewModel() =>
      ProfileSettingsViewModel();

  MainScreenViewModel _makeMainScreenViewModel() =>
      MainScreenViewModel(myAuth: myAuth);

  JobCubit _makeJobCubit() => JobCubit();

  ChatScreenViewModel _makeChatScreenViewModel() => ChatScreenViewModel();
}

class _ScreenFactoryDefault implements ScreenFactory {
  final _DIContainer _diContainer;
  const _ScreenFactoryDefault(this._diContainer);

  @override
  Widget makeLoaderSplash() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeSplashViewModel(),
      child: const SplashScreen(),
    );
  }

  @override
  Widget makeAuthGoogle() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => _diContainer._makeGoogleAuthViewModel()),
        BlocProvider<AuthBloc>(
          create: (context) => _diContainer._makeAuthBloc(),
          lazy: false,
        ),
      ],
      child: const GoogleAuthScreen(),
    );
  }

  @override
  Widget makeAuthCredentials() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => _diContainer._makeCredentialsAuthViewModel()),
        BlocProvider<AuthBloc>(
          create: (context) => _diContainer._makeAuthBloc(),
          lazy: false,
        ),
      ],
      child: const CredentialsAuthScreen(),
    );
  }

  @override
  Widget makeSelectCategory() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeSelectCategoryViewModel(),
      child: const SelectCategoryScreen(),
    );
  }

  @override
  Widget makeChooseExpertises() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeChooseExpertisesViewModel(),
      child: const ChooseExpertisesScreen(),
    );
  }

  @override
  Widget makeProfileSettings() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeProfileSettingsViewModel(),
      child: const ProfileSettingsScreen(),
    );
  }

  @override
  Widget makeMainScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => _diContainer._makeMainScreenViewModel()),
        BlocProvider<JobCubit>(
          create: (context) => _diContainer._makeJobCubit(),
        ),
      ],
      child: const MainScreen(),
    );
  }

  @override
  Widget makeVacancyInfo() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeMainScreenViewModel(),
      child: const VacancyInfoScreen(),
    );
  }

  @override
  Widget makeHelpChat() {
    return ChangeNotifierProvider(
      create: (context) => _diContainer._makeChatScreenViewModel(),
      child: const ChatScreen(),
    );
  }
}
