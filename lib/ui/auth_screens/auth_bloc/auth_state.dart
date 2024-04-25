part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

enum AuthVarProgress { signInProgress, signUpProgress, googleSignInProgress }

class AuthInProgress extends AuthState {
  final AuthVarProgress progress;

  AuthInProgress({required this.progress});
  @override
  List<Object?> get props => [progress];
}

class AuthSuccess extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthException extends AuthState {
  final Object? emailError;
  final Object? passwordError;

  AuthException({
    required this.emailError,
    required this.passwordError,
  });

  @override
  List<Object?> get props => [emailError, passwordError];
}
