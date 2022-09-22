import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/ui/authentication/widgets/complete_account_form.dart';

class CompleteAccountScreen extends StatelessWidget {
  const CompleteAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complete Account Screen'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(AppEdges.content),
        child: CompleteAccountForm(),
      ),
    );
  }
}
