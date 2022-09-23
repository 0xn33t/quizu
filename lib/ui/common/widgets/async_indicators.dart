import 'package:flutter/material.dart';

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
        message ?? 'General error message',
      ),
    );
  }
}
