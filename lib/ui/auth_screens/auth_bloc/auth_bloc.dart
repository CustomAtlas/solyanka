import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solyanka/domain/api_clients/firebase/firebase.dart';
import 'package:solyanka/navigation/route_names.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        switch (event) {
          case SignInAuth():
            await _signIn(event, emit);
          case SignUpAuth():
            await _signUp(event, emit);
          case GoogleSignIn():
            await _googleSignIn(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  bool hasException = false;
  bool canceledGoogleAuth = false;
  String? emailError;
  String? passwordError;

  Future<void> _signIn(
    SignInAuth event,
    Emitter<AuthState> emit,
  ) async {
    final myAuth = MyAuth();
    emit(AuthInProgress(progress: AuthVarProgress.signInProgress));
    if (event.email.length < 4 ||
        !event.email.contains('@') ||
        !event.email.contains('.')) {
      emailError = 'Invalid email';
      passwordError = null;
      hasException = true;
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    } else if (event.password.length < 6) {
      emailError = null;
      passwordError = 'Password too short';
      hasException = true;
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    await myAuth.signIn(email: event.email, password: event.password);
    emailError = myAuth.emailError;
    passwordError = myAuth.passwordError;
    hasException = myAuth.hasException;

    if (hasException) {
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(AuthSuccess());

    if (event.context.mounted && !hasException) {
      Future.delayed(const Duration(milliseconds: 2400)).then(
        (_) => Navigator.of(event.context).pushNamedAndRemoveUntil(
            NavigationRouteNames.selectCategory, (_) => false),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', event.email);
      prefs.setBool('auth', true);
    }
  }

  Future<void> _signUp(
    SignUpAuth event,
    Emitter<AuthState> emit,
  ) async {
    final myAuth = MyAuth();
    emit(AuthInProgress(progress: AuthVarProgress.signUpProgress));
    if (event.email.length < 4 ||
        !event.email.contains('@') ||
        !event.email.contains('.')) {
      emailError = 'Invalid email';
      passwordError = null;
      hasException = true;
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    } else if (event.password.length < 6) {
      emailError = null;
      passwordError = 'Password too short';
      hasException = true;
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    await myAuth.signUp(email: event.email, password: event.password);
    emailError = myAuth.emailError;
    passwordError = myAuth.passwordError;
    hasException = myAuth.hasException;

    if (hasException) {
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(AuthSuccess());

    if (event.context.mounted && !hasException) {
      Future.delayed(const Duration(milliseconds: 2400)).then(
        (_) => Navigator.of(event.context).pushNamedAndRemoveUntil(
            NavigationRouteNames.selectCategory, (_) => false),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', event.email);
      prefs.setBool('auth', true);
    }
  }

  Future<void> _googleSignIn(
    GoogleSignIn event,
    Emitter<AuthState> emit,
  ) async {
    final myAuth = MyAuth();
    emit(AuthInProgress(progress: AuthVarProgress.googleSignInProgress));
    await myAuth.googleSignIn();
    emailError = myAuth.emailError;
    hasException = myAuth.hasException;
    canceledGoogleAuth = myAuth.canceledGoogleAuth;

    if (hasException || canceledGoogleAuth) {
      emit(AuthException(
        emailError: emailError,
        passwordError: passwordError,
      ));
      return;
    }

    emit(AuthSuccess());

    if (event.context.mounted && !hasException) {
      Navigator.of(event.context).pushNamedAndRemoveUntil(
          NavigationRouteNames.selectCategory, (_) => false);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', myAuth.email ?? 'email');
      prefs.setBool('auth', true);
    }
  }
}
