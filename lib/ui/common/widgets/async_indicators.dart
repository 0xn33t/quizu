import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';

class LoadingIndicator extends StatelessWidget {
  final double? dimension;
  final double? strokeWidth;
  final bool center;

  const LoadingIndicator({
    Key? key,
    this.dimension,
    this.strokeWidth,
    this.center = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loader = SizedBox(
      width: dimension ?? 24,
      height: dimension ?? 24,
      child: CircularProgressIndicator(strokeWidth: strokeWidth ?? 1.8),
    );
    return center ? Center(child: loader) : loader;
  }
}

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
        style:
            Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
      ),
    );
  }
}
