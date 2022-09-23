import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/ui/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();
  final _accountRepository = AccountRepository();

  @override
  void initState() {
    bootstrap();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> bootstrap() async {
    final authorizedAccount = await _storage.read(
      key: Settings.authStorageKey,
      aOptions: const AndroidOptions(resetOnError: true),
    );
    print(authorizedAccount);
    if (authorizedAccount != null) {
      final account = Account.fromJson(jsonDecode(authorizedAccount));
      if (!mounted) return;
      AccountState.read(context).setAccount(account);
      final verified = await _accountRepository.tokenVerification();
      print('verified: $verified');
      if (verified) {
        context.router.replaceAll(const [TabsRoute()]);
        return;
      }
    }
    await context.router.replaceAll([const LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
