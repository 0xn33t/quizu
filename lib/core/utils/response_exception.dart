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
}

abstract class ResponseExceptionCodes {
  static const String loginFailed = 'L-001';
  static const String updateUserFailed = 'L-002';
  static const String getQuestionsFailed = 'L-003';
  static const String getTopScoresFailed = 'L-004';
  static const String getUserFailed = 'L-005';
}
