import 'dart:convert';
import 'dart:io';

import 'package:quiz_u/core/config/endpoints.dart';
import 'package:quiz_u/core/models/login_response.dart';
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
}
