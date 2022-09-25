import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error ?? context.l10n.somethingWentWrong),
      ),
    );
  }
}
