import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/main_view_model.dart';
import 'package:solyanka/navigation/route_names.dart';

abstract class MyAppNavigation {
  Map<String, Widget Function(BuildContext)> get routes;
}

class MyApp extends StatelessWidget {
  final MyAppNavigation navigation;

  const MyApp({super.key, required this.navigation});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<MainViewModel>().themeMode;
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: NavigationRouteNames.loaderSplashScreen,
      routes: navigation.routes,
    );
  }
}
