import 'package:quiz_u/core/config/settings.dart';

class Environment {
  const Environment({required this.uri});

  final Uri uri;

  factory Environment.sandbox() => Environment(
        uri: Uri(
          scheme: 'https',
          host: 'quizu.okoul.com',
        ),
      );

  factory Environment.production() => Environment(
        uri: Uri(
          scheme: 'https',
          host: 'quizu.okoul.com',
        ),
      );

  factory Environment.get() =>
      Settings.sandbox ? Environment.sandbox() : Environment.production();
}
