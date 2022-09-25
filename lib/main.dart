import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/l10n/index.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'dart:async';

import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/themes.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AccountState>(
        create: (context) => AccountState(),
      ),
    ],
    child: const AppBootstrap(),
  ));
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({Key? key}) : super(key: key);

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  final _appRouter = AppRouter(navigatorKey: AppNavigatorState.navigatorKey);

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        _appRouter.replaceAll(const [NoConnectionRoute()]);
      }
    } on PlatformException catch (_) {}
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      await _appRouter.push(const NoConnectionRoute());
    } else {
      _appRouter.removeWhere(
          (route) => route.name == const NoConnectionRoute().routeName);
      if (!_appRouter.hasEntries) {
        await _appRouter.push(const SplashRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Settings.appName,
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      locale: Settings.appLocale,
      localizationsDelegates: AppL10n.localizationsDelegates,
      supportedLocales: AppL10n.supportedLocales,
      theme: AppThemes.lightTheme,
    );
  }
}
