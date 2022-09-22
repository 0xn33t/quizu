import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/ui/authentication/widgets/verification_form.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key, required this.mobile}) : super(key: key);

  final String mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppEdges.content),
        child: VerificationForm(mobile: mobile),
      ),
    );
  }
}
