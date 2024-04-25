import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solyanka/resources/app_fonts.dart';
import 'package:solyanka/resources/app_images.dart';
import 'package:solyanka/resources/app_styles.dart';
import 'package:solyanka/ui/auth_screens/auth_bloc/auth_bloc.dart';
import 'package:solyanka/ui/auth_screens/credentials_auth_view_model.dart';
import 'package:solyanka/ui/auth_screens/google_auth_screen.dart';

class CredentialsAuthScreen extends StatelessWidget {
  const CredentialsAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CredentialsAuthViewModel>();
    const buttonsTextStyle = TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white);
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AuthBloc>(context);
          final emailError =
              state is AuthException ? state.emailError?.toString() : null;
          final passwordError =
              state is AuthException ? state.passwordError?.toString() : null;
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Image(image: AppImages.logoIcon, width: 220),
                      Text(
                        "Login to Your Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: AppFonts.basisGrotesquePro,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color.fromARGB(255, 64, 64, 64)
                                  : const Color.fromARGB(255, 148, 147, 147),
                        ),
                      ),
                      const SizedBox(height: 28),
                      model.isEmailFieldEmty
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Email'),
                              ),
                            ),
                      _TextFieldWidget(
                          controller: model.eController,
                          obscureText: false,
                          hintText: 'Email',
                          error: emailError),
                      const SizedBox(height: 24),
                      model.isPasswordFieldEmty
                          ? const SizedBox.shrink()
                          : const Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Password'),
                              ),
                            ),
                      _TextFieldWidget(
                          controller: model.pController,
                          obscureText: true,
                          hintText: 'Password',
                          error: passwordError),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: () {
                          if (state is AuthInProgress || state is AuthSuccess) {
                            return;
                          } else {
                            bloc.add(
                              SignInAuth(
                                  email: model.eController.text,
                                  password: model.pController.text,
                                  context: context),
                            );
                            model.showNotification(context);
                          }
                        },
                        style: AppStyles.firstScreensButtonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            state is AuthInProgress &&
                                    state.progress ==
                                        AuthVarProgress.signInProgress
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator())
                                : const Text(
                                    'Sign in',
                                    style: buttonsTextStyle,
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (state is AuthInProgress || state is AuthSuccess) {
                            return;
                          } else {
                            bloc.add(
                              SignUpAuth(
                                  email: model.eController.text,
                                  password: model.pController.text,
                                  context: context),
                            );
                            model.showNotification(context);
                          }
                        },
                        style: AppStyles.firstScreensButtonStyle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: state is AuthInProgress &&
                                      state.progress ==
                                          AuthVarProgress.signUpProgress
                                  ? const Center(
                                      child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator()),
                                    )
                                  : const Text(
                                      'Sign up with email and password',
                                      textAlign: TextAlign.center,
                                      style: buttonsTextStyle),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      const DividerWidget(divideText: 'or continue with'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            if (state is AuthInProgress ||
                                state is AuthSuccess) {
                              return;
                            } else {
                              bloc.add(GoogleSignIn(context: context));
                            }
                          },
                          style: const ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 20)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                side: BorderSide(width: 1, color: Colors.grey),
                              ),
                            ),
                          ),
                          child: state is AuthInProgress &&
                                  state.progress ==
                                      AuthVarProgress.googleSignInProgress
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator())
                              : const Hero(
                                  tag: 'Google',
                                  child: Image(
                                    image: AppImages.googleIcon,
                                    width: 24,
                                  ),
                                )),
                    ],
                  ),
                ),
              ),
              state is AuthSuccess
                  ? AnimatedPositioned(
                      height: 70,
                      top: model.isSuccess ? 0 : -70,
                      right: 0,
                      left: 0,
                      duration: const Duration(milliseconds: 100),
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                            color: AppStyles.mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'Authenticated successfully!',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget({
    required this.controller,
    required this.obscureText,
    required this.hintText,
    required this.error,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          errorText: error,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
    );
  }
}
