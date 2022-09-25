import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(context.l10n.noConnections),
      ),
    );
  }
}
