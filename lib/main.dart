import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solyanka/di/di_container.dart';
import 'package:solyanka/domain/api_clients/firebase/firebase_options.dart';

abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final app = appFactory.makeApp();
  runApp(app);
}
