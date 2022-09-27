import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/models/country.dart';
import 'package:quiz_u/core/models/user.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/utils/country_utils.dart';

class AccountState extends ChangeNotifier {
  static AccountState read(BuildContext context) =>
      context.read<AccountState>();

  Account? _account;
  Account? get account => _account;

  User? _user;
  User? get user => _user;

  String _regionCode = Settings.fallbackCarrierRegionCode;
  String get regionCode => _regionCode;

  bool _tokenVerified = false;
  bool get tokenVerified => _tokenVerified;

  List<UserScore> _scores = [];
  List<UserScore> get scores => _scores;

  bool get isAuthorized => account != null && user != null && tokenVerified;

  bool get isAccountCompleted => isAuthorized && user!.name != null;

  void setAccount(Account? account, {bool notifyListeners = true}) {
    _account = account;
    if (notifyListeners) this.notifyListeners();
  }

  void setUser(User? user, {bool notifyListeners = true}) {
    _user = user;
    if (notifyListeners) this.notifyListeners();
  }

  void setDeviceRegionCode(String region, {bool notifyListeners = true}) {
    _regionCode = region;
    if (notifyListeners) this.notifyListeners();
  }

  void setTokenVerification(bool verified, {bool notifyListeners = true}) {
    _tokenVerified = verified;
    if (notifyListeners) this.notifyListeners();
  }

  void setUserScores(List<UserScore> scores, {bool notifyListeners = true}) {
    _scores = scores;
    if (notifyListeners) this.notifyListeners();
  }

  void addUserScore(UserScore score, {bool notifyListeners = true}) {
    _scores = [..._scores, score];
    if (notifyListeners) this.notifyListeners();
  }

  void logout({bool notifyListeners = true}) {
    _account = null;
    _user = null;
    _tokenVerified = false;
    _scores = [];
    _regionCode = Settings.fallbackCarrierRegionCode;
    if (notifyListeners) this.notifyListeners();
  }

  Country? get deviceCountry => CountryUtils.getCountryByRegionCode(regionCode);
}
