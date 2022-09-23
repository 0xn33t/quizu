import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/models/user.dart';

class AccountState extends ChangeNotifier {
  static AccountState read(BuildContext context) =>
      context.read<AccountState>();

  Account? _account;
  Account? get account => _account;

  User? _user;
  User? get user => _user;

  void setAccount(Account? account, {bool notifyListeners = true}) {
    _account = account;
    if (notifyListeners) this.notifyListeners();
  }

  void setUser(User? user, {bool notifyListeners = true}) {
    _user = user;
    if (notifyListeners) this.notifyListeners();
  }

  void logout({bool notifyListeners = true}) {
    _user = null;
    _account = null;
    if (notifyListeners) this.notifyListeners();
  }
}
