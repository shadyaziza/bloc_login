import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../../data/models/task_user.dart';

abstract class AuthState extends Equatable {
  const AuthState() : super();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthGranted extends AuthState {
  /// User from task_user.dart
  final TaskUser taskUser;
  const AuthGranted({required this.taskUser}) : super();

  Map<String, dynamic> toMap() {
    return {
      'currentUser': taskUser.toJson(),
    };
  }

  factory AuthGranted.fromMap(Map<String, dynamic> map) {
    return AuthGranted(

        /// from SharedPreferences
        taskUser: TaskUser.fromMap(map['currentUser']));
  }

  String toJson() => json.encode(toMap());

  factory AuthGranted.fromJson(String source) =>
      AuthGranted.fromMap(json.decode(source));

  @override
  List<Object?> get props => [taskUser];
}

class AuthDenied extends AuthState {
  final List<String> errors;
  const AuthDenied(this.errors);

  @override
  List<Object> get props => [errors];
}

class PasswordResetSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
