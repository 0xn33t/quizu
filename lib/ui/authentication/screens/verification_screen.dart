import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/ui/authentication/widgets/verification_form.dart';
import 'package:quiz_u/ui/common/widgets/unfocus_wrapper.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key, required this.mobile}) : super(key: key);

  final String mobile;

  @override
  Widget build(BuildContext context) {
    return UnfocusWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.mobileVerification),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppEdges.content),
          child: VerificationForm(mobile: mobile),
        ),
      ),
    );
  }
}
