import 'dart:async';

import 'package:bloc_login/data/dataproviders/http.provider.dart';
import 'package:bloc_login/data/models/http/http.response.dart';
import 'package:dio/dio.dart';

class ForgotPasswordRepository {
  final _httpProvider = HttpProvider();

  Future<HttpResponse> request({String? email}) async {
    Response response =
        await (_httpProvider.fgtRequest(email) as FutureOr<Response<dynamic>>);
    return HttpResponse.fromJson(response.data, response.statusCode);
  }

  Future<HttpResponse> verifyCode({String? email, code}) async {
    Response response = await (_httpProvider.fgtVerifyCode(email, code)
        as FutureOr<Response<dynamic>>);
    return HttpResponse.fromJson(response.data, response.statusCode);
  }

  Future<HttpResponse> resetPassword(
      {String? email, String? newPassword, String? cPassword, code}) async {
    Response response = await (_httpProvider.fgtResetPwd(
        email, newPassword, cPassword, code) as FutureOr<Response<dynamic>>);
    return HttpResponse.fromJson(response.data, response.statusCode);
  }
}
