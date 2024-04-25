import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/ui/splash_screen/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final model = context.read<SplashViewModel>();
    model.goToNextScreen(context);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            child: Image(
              image: AppImages.splashScreen,
              color: const Color.fromARGB(255, 23, 41, 58).withOpacity(0.8),
              colorBlendMode: BlendMode.softLight,
              opacity: const AlwaysStoppedAnimation(0.3),
            ),
          ),
          const Align(
            alignment: Alignment(0, 0.7),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome to Solyanka',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.w500,
                      fontSize: 46,
                      fontFamily: AppFonts.basisGrotesquePro,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Discover Your Dream Job with the Ultimate Job Portal App - Where Jobs Find You!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
