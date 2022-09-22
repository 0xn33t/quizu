import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));
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
