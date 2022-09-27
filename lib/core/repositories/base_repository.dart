import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/http_client.dart';
import 'package:quiz_u/core/utils/response_exception.dart';

typedef AuthorizedRequest = Future<Response> Function(String token);

class BaseRepository {
  BaseRepository([HttpClient? httpClient])
      : httpClient = httpClient ?? HttpClient();

  @protected
  late final HttpClient httpClient;

  final _context = AppNavigatorState.navigatorKey.currentContext!;

  AccountState? get _accountState => AccountState.read(_context);

  Future<Response> authorized(AuthorizedRequest auth) {
    if (_accountState?.account != null) {
      return auth(_accountState!.account!.accessToken);
    }
    throw ResponseExceptions.unauthorized;
  }
}
