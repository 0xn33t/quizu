import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';

class ErrorMessageIndicator extends StatelessWidget {
  final String? message;
  final Color? messageColor;
  final double? messageSize;

  const ErrorMessageIndicator({
    super.key,
    this.message,
    this.messageColor,
    this.messageSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? context.l10n.somethingWentWrong,
      ),
    );
  }
}
