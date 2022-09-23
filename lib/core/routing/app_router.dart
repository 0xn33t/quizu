import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/ui/authentication/screens/complete_account_screen.dart';
import 'package:quiz_u/ui/authentication/screens/login_screen.dart';
import 'package:quiz_u/ui/authentication/screens/verification_screen.dart';
import 'package:quiz_u/ui/index.dart';
import 'package:quiz_u/ui/quiz/screens/quiz_ended_screen.dart';
import 'package:quiz_u/ui/quiz/screens/quiz_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: NoConnectionScreen),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: VerificationScreen),
    AutoRoute(page: CompleteAccountScreen),
    AutoRoute(page: QuizScreen),
    AutoRoute(page: QuizEndedScreen),
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
class AppRouter extends _$AppRouter {
  AppRouter({GlobalKey<NavigatorState>? navigatorKey}) : super(navigatorKey);
}

abstract class AppNavigatorState {
  static final navigatorKey = GlobalKey<NavigatorState>();
}
