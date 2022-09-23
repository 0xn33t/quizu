import 'dart:convert';
import 'dart:io';

import 'package:quiz_u/core/config/endpoints.dart';
import 'package:quiz_u/core/models/login_response.dart';
import 'package:quiz_u/core/models/user.dart';
import 'package:quiz_u/core/requests/update_user_request.dart';
import 'package:quiz_u/core/requests/login_request.dart';
import 'package:quiz_u/core/utils/http_client.dart';
import 'package:quiz_u/core/utils/response_exception.dart';

import 'base_repository.dart';

class AccountRepository extends BaseRepository {
  AccountRepository([HttpClient? httpClient]) : super(httpClient);

  Future<LoginResponse> login(LoginRequest request) async {
    final res = await httpClient.request(
      options: HttpClientOptions(
        method: HttpClientMethod.post,
        endpoint: Endpoints.login,
        body: request.toJson(),
      ),
    );

    if (res.statusCode == HttpStatus.created) {
      return LoginResponse.fromJson(jsonDecode(res.body));
    }
    throw ResponseExceptions.loginFailed;
  }

  Future<User> updateUser(UpdateUserRequest request) async {
    final res = await authorized(
      (token) => httpClient.request(
        options: HttpClientOptions(
          method: HttpClientMethod.post,
          endpoint: Endpoints.updateUser,
          body: request.toJson(),
          accessToken: token,
        ),
      ),
    );

    if (res.statusCode == HttpStatus.created) {
      return User.fromJson(jsonDecode(res.body));
    }
    throw ResponseExceptions.updateUserFailed;
  }

  Future<bool> tokenVerification() async {
    final res = await authorized(
      (token) => httpClient.request(
        options: HttpClientOptions(
          method: HttpClientMethod.get,
          endpoint: Endpoints.token,
          accessToken: token,
        ),
      ),
    );
    if (res.statusCode == HttpStatus.ok) {
      return jsonDecode(res.body)['success'] == true;
    }
    return false;
  }
}
