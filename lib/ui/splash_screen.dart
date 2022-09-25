import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/index.dart';

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
    await BootstrapCommand().execute();
    if (!mounted) return;
    final state = AccountState.read(context);
    if (state.account != null && state.tokenVerified) {
      context.router.replaceAll(const [TabsRoute()]);
      return;
    }
    await context.router.replaceAll(const [LoginRoute()]);
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
