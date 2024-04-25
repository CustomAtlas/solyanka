import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:solyanka/ui/auth_screens/google_auth_view_model.dart';

class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<GoogleAuthViewModel>();
    timeDilation = 3.0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(image: AppImages.logoIcon, width: 180),
              const Text(
                'Solyanka',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  fontFamily: AppFonts.basisGrotesquePro,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Let's get started!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 42,
                  fontFamily: AppFonts.basisGrotesquePro,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color.fromARGB(255, 64, 64, 64)
                      : const Color.fromARGB(255, 148, 147, 147),
                ),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<AuthBloc>(context);
                  final emailError = state is AuthException
                      ? state.emailError?.toString()
                      : null;
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        emailError ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            bloc.add(GoogleSignIn(context: context)),
                        style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(vertical: 14)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              side: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Hero(
                              tag: 'Google',
                              child:
                                  Image(image: AppImages.googleIcon, width: 24),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 60),
              const DividerWidget(divideText: 'or'),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => model.goToCredentialsAuth(context),
                style: AppStyles.firstScreensButtonStyle,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in with password',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, required this.divideText});

  final String divideText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1.2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            divideText,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        const Expanded(child: Divider(thickness: 1.2)),
      ],
    );
  }
}
