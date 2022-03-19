import 'dart:async';

import 'package:bloc_login/data/models/task_user.dart';
import 'package:bloc_login/data/models/user_model.dart';
import 'package:bloc_login/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
      {required AuthenticationRepository authenticationRepository,
      required SharedPreferences prefs})
      : _authenticationRepository = authenticationRepository,
        _prefs = prefs,
        super(AuthInitial()) {
    stream.listen((state) {
      print({'AuthBloc': state});
    });
    // handle auth init
    on<AuthInit>(_onAuthenticationInit);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthLoginRequested>(_onAuthenticationLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  final AuthenticationRepository? _authenticationRepository;
  final SharedPreferences _prefs;

  Future<FutureOr<void>> _onAuthenticationInit(
      AuthInit event, Emitter<AuthState> emit) async {
    final currentUser = _prefs.getString('currentUser');
    if (currentUser != null) {
      final user = TaskUser.fromJson(currentUser);
      if (user.expired) {
        emit(AuthInitial());
      } else {
        emit(AuthGranted(taskUser: user));
      }
    } else {
      emit(AuthInitial());
    }
  }

  Future<FutureOr<void>> _onAuthenticationLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    final taskUser = (state as AuthGranted).taskUser.copyWith(expired: true);
    emit(AuthLoading());
    _prefs.setString('currentUser', taskUser.toJson());

    emit(AuthInitial());
  }

  Future<FutureOr<void>> _onAuthenticationLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = _prefs.getString('currentUser');
    if (result != null) {
      final stored = TaskUser.fromJson(result);
      if (stored.email == event.email && stored.password == event.password) {
        final _currentUser = stored.copyWith(expired: false);
        await _prefs.setString('currentUser', _currentUser.toJson());
        emit(AuthGranted(taskUser: _currentUser));
      } else {
        emit(const AuthDenied(['Invalid credentials']));
      }
    } else {
      emit(const AuthDenied(['No User']));
    }
  }

  FutureOr<void> _onAuthRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    final _currentUser = TaskUser(

        /// expired is true to mimic an email validation that is required by the user in order to login
        /// this prevents the user from logging in if they retstarted the app as it will dispatch [AuthInit]
        /// it may be better to emit a new state just for registeration but for the sake of simplicit we will
        /// let expired handle the logout and the registered state

        email: event.email,
        password: event.password,
        expired: true);
    final result = await _prefs.setString('currentUser', _currentUser.toJson());
    if (result) {
      emit(AuthGranted(taskUser: _currentUser));
    } else {
      emit(const AuthDenied(['Failed to register, please try again']));
    }
  }

  FutureOr<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<AuthState> emit) async {
    final result = _prefs.getString('currentUser');
    if (result != null) {
      final stored = TaskUser.fromJson(result);
      if (stored.email == event.email) {
        final updatedUser = stored.copyWith(password: event.password);
        final result =
            await _prefs.setString('currentUser', updatedUser.toJson());
        if (result) {
          emit(PasswordResetSuccess());
        } else {
          emit(
              const AuthDenied(['Failed to reset password, please try again']));
        }
      } else {
        emit(const AuthDenied(['Email does not match']));
      }
    } else {
      emit(const AuthDenied(['User does not exist']));
    }
  }
}
