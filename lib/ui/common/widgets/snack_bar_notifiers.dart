import 'package:flutter/material.dart';
import 'package:quiz_u/core/theme/styles.dart';

class ErrorSnackBar extends SnackBar {
  const ErrorSnackBar({Key? key, required Widget content})
      : super(
          key: key,
          content: content,
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppEdges.content),
          elevation: 0,
        );
}

class SuccessSnackBar extends SnackBar {
  const SuccessSnackBar({Key? key, required Widget content})
      : super(
          key: key,
          content: content,
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppEdges.content),
          elevation: 0,
        );
}
