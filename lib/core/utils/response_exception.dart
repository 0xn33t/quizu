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
}

abstract class ResponseExceptionCodes {
  static const String loginFailed = 'L-001';
}
