import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';

class ResponseException implements Exception {
  const ResponseException(this.code);

  final String code;

  @override
  String toString() => 'ResponseException - $code';

  @override
  bool operator ==(Object other) =>
      other is ResponseException && other.code == code;

  @override
  int get hashCode => code.hashCode;

  String message(BuildContext context) {
    switch (code) {
      case ResponseExceptionCodes.loginFailed:
        return context.l10n.loginFailed;
      case ResponseExceptionCodes.updateUserFailed:
        return context.l10n.completeAccountFailed;
      case ResponseExceptionCodes.getQuestionsFailed:
        return context.l10n.getQuestionsFailed;
      case ResponseExceptionCodes.getTopScoresFailed:
        return context.l10n.getTopScoresFailed;
      case ResponseExceptionCodes.getUserFailed:
        return context.l10n.getUserInfoFailed;
      case ResponseExceptionCodes.unauthorized:
        return context.l10n.getUserInfoFailed;
      default:
        return context.l10n.somethingWentWrong;
    }
  }
}

extension ResponseExceptions on ResponseException {
  static const loginFailed =
      ResponseException(ResponseExceptionCodes.loginFailed);
  static const updateUserFailed =
      ResponseException(ResponseExceptionCodes.updateUserFailed);
  static const getQuestionsFailed =
      ResponseException(ResponseExceptionCodes.getQuestionsFailed);
  static const getTopScoresFailed =
      ResponseException(ResponseExceptionCodes.getTopScoresFailed);
  static const getUserFailed =
      ResponseException(ResponseExceptionCodes.getUserFailed);
  static const unauthorized =
      ResponseException(ResponseExceptionCodes.unauthorized);
}

abstract class ResponseExceptionCodes {
  static const String loginFailed = 'L-001';
  static const String updateUserFailed = 'L-002';
  static const String getQuestionsFailed = 'L-003';
  static const String getTopScoresFailed = 'L-004';
  static const String getUserFailed = 'L-005';
  static const String unauthorized = 'L-006';
}
