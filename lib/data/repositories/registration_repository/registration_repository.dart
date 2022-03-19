import 'dart:async';

import 'package:bloc_login/data/dataproviders/http.provider.dart';
import 'package:dio/dio.dart';

class RegistrationRepository {
  final _httpProvider = HttpProvider();

  Future<Response> publicRegister(
      {String? email, String? password, String? cpassword}) async {
    return await (_httpProvider.reg(
        username: email,
        password: password,
        cpassword: cpassword) as FutureOr<Response<dynamic>>);
  }

  Future<Response> activate({String? email, String? code}) async {
    return await (_httpProvider.activate(username: email, code: code)
        as FutureOr<Response<dynamic>>);
  }

  Future<Response> validateOtp({String? code}) async {
    return await (_httpProvider.otp_check(code: code)
        as FutureOr<Response<dynamic>>);
  }
}
