import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/http_client.dart';

typedef AuthorizedRequest = Future<Response> Function(String token);

class BaseRepository {
  BaseRepository([HttpClient? httpClient])
      : httpClient = httpClient ?? HttpClient();

  @protected
  late final HttpClient httpClient;

  Future<Response> authorized(AuthorizedRequest auth) {
    final context = AppNavigatorState.navigatorKey.currentContext!;
    final account = AccountState.read(context).account;
    return auth(account!.accessToken);
  }
}
