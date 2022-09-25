import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/repositories/score_repository.dart';
import 'package:quiz_u/core/requests/record_score_request.dart';
import 'package:quiz_u/core/routing/app_router.dart' show AppNavigatorState;
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/phone_number_utils.dart';

abstract class Command {
  Command(
    this.name, {
    FlutterSecureStorage? storage,
    AccountRepository? accountRepository,
    ScoreRepository? scoreRepository,
  })  : storage = storage ?? const FlutterSecureStorage(),
        accountRepository = accountRepository ?? AccountRepository(),
        scoreRepository = scoreRepository ?? ScoreRepository();

  final String name;
  final FlutterSecureStorage storage;
  final AccountRepository accountRepository;
  final ScoreRepository scoreRepository;

  @override
  String toString() => name;

  BuildContext get context => AppNavigatorState.navigatorKey.currentContext!;

  AccountState get accountState => AccountState.read(context);
}

class BootstrapCommand extends Command {
  BootstrapCommand({
    FlutterSecureStorage? storage,
    AccountRepository? accountRepository,
    ScoreRepository? scoreRepository,
  }) : super(
          'Bootstrap Command',
          storage: storage,
          accountRepository: accountRepository,
          scoreRepository: scoreRepository,
        );

  Future<void> execute() async {
    final regionCode = await PhoneNumberUtils().carrierRegionCode();
    accountState.setDeviceRegionCode(regionCode, notifyListeners: false);
    final authorizedAccount = await storage.read(
      key: Settings.authStorageKey,
      aOptions: const AndroidOptions(resetOnError: true),
    );
    if (authorizedAccount != null) {
      final account = Account.fromJson(jsonDecode(authorizedAccount));
      accountState.setAccount(account, notifyListeners: false);
      final verified = await accountRepository.tokenVerification();
      accountState.setTokenVerification(verified, notifyListeners: false);
      final userScores = await storage.read(key: Settings.scoresStorageKey);
      if (userScores != null) {
        final userScoresList = UserScore.fromJsonList(jsonDecode(userScores));
        accountState.setUserScores(userScoresList);
      }
    }
  }
}

class RecordScoreCommand extends Command {
  RecordScoreCommand({
    FlutterSecureStorage? storage,
    AccountRepository? accountRepository,
    ScoreRepository? scoreRepository,
  }) : super(
          'Record Score Command',
          storage: storage,
          accountRepository: accountRepository,
          scoreRepository: scoreRepository,
        );

  Future<void> execute(int score) async {
    accountState.addUserScore(UserScore(date: DateTime.now(), score: score));
    await storage.write(
      key: Settings.scoresStorageKey,
      value: jsonEncode(accountState.scores),
    );
    await scoreRepository.recordScore(
      RecordScoreRequest(score: score.toString()),
    );
  }
}

class LogoutCommand extends Command {
  LogoutCommand({
    FlutterSecureStorage? storage,
    AccountRepository? accountRepository,
    ScoreRepository? scoreRepository,
  }) : super(
          'Logout Command',
          storage: storage,
          accountRepository: accountRepository,
          scoreRepository: scoreRepository,
        );

  Future<void> execute() async {
    accountState.logout();
    await storage.deleteAll();
  }
}
