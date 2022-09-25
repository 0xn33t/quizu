import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/models/country.dart';
import 'package:quiz_u/core/utils/country_utils.dart';

class AccountState extends ChangeNotifier {
  static AccountState read(BuildContext context) =>
      context.read<AccountState>();

  Account? _account;
  Account? get account => _account;

  String _regionCode = Settings.fallbackCarrierRegionCode;
  String get regionCode => _regionCode;

  void setAccount(Account? account, {bool notifyListeners = true}) {
    _account = account;
    if (notifyListeners) this.notifyListeners();
  }

  void logout({bool notifyListeners = true}) {
    _account = null;
    if (notifyListeners) this.notifyListeners();
  }

  void setDeviceRegionCode(String region, {bool notifyListeners = true}) {
    _regionCode = region;
    if (notifyListeners) this.notifyListeners();
  }

  Country? get deviceCountry => CountryUtils.getCountryByRegionCode(regionCode);
}
