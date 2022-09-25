import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/common/widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bootstrap();
    super.initState();
  }

  Future<void> bootstrap() async {
    try {
      await BootstrapCommand().execute();
      if (!mounted) return;
      final state = AccountState.read(context);
      if (state.isAuthorized) {
        context.router.replaceAll(const [TabsRoute()]);
        return;
      }
      await context.router.replaceAll(const [LoginRoute()]);
    } catch (e) {
      await context.router
          .replaceAll([ErrorRoute(error: context.l10n.initializeAppFailed)]);
    }
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
