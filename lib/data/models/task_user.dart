import 'dart:convert';

class TaskUser {
  final String email;
  final String password;
  final bool expired;
  const TaskUser({
    required this.email,
    required this.password,
    bool? expired,
  }) : expired = expired ?? false;

  factory TaskUser.empty() => const TaskUser(
        email: '',
        password: '',
        expired: true,
      );

  //copyWith
  TaskUser copyWith({
    String? email,
    String? password,
    bool? expired,
  }) =>
      TaskUser(
        email: email ?? this.email,
        password: password ?? this.password,
        expired: expired ?? this.expired,
      );
  factory TaskUser.fromMap(Map<String, dynamic> json) => TaskUser(
        email: json['email'] as String,
        password: json['password'] as String,
        expired: json['expired'] as bool,
      );
//fromJson
  factory TaskUser.fromJson(String json) => TaskUser.fromMap(jsonDecode(json));
  String toJson() => json.encode({
        'email': email,
        'password': password,
        'expired': expired,
      });
}
