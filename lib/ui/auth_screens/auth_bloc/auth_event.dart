part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {}

class SignInAuth extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignInAuth({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [email, password, context];
}

class SignUpAuth extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignUpAuth({
    required this.email,
    required this.password,
    required this.context,
  });
  @override
  List<Object?> get props => [email, password, context];
}

class GoogleSignIn extends AuthEvent {
  final BuildContext context;

  GoogleSignIn({required this.context});
  @override
  List<Object?> get props => [context];
}
