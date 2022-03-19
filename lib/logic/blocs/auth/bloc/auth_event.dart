part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class AuthInit extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested(
    this.email,
    this.password,
  );
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested(
    this.email,
    this.password,
  );
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthRefreshRequested extends AuthEvent {
  const AuthRefreshRequested(this.token, this.device, this.user);
  final String token;
  final String device;
  final User user;

  @override
  List<Object> get props => [token, device, user != null];
}

class AuthLogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthEvent {
  const Authenticated(this.token, this.user);
  final String token;
  final User user;

  @override
  List<Object> get props => [token, user];
}

class ResetPasswordRequested extends AuthEvent {
  const ResetPasswordRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
