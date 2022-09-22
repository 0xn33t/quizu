import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/ui/authentication/screens/complete_account_screen.dart';
import 'package:quiz_u/ui/authentication/screens/login_screen.dart';
import 'package:quiz_u/ui/authentication/screens/verification_screen.dart';
import 'package:quiz_u/ui/index.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: NoConnectionScreen),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: VerificationScreen),
    AutoRoute(page: CompleteAccountScreen),
    AutoRoute(
      page: TabsScreen,
      children: [
        AutoRoute(page: HomeScreen),
        AutoRoute(page: HomeScreen),
        AutoRoute(page: HomeScreen),
        AutoRoute(page: HomeScreen),
      ],
    ),
  ],
)
class AppRouter extends _$AppRouter {}
