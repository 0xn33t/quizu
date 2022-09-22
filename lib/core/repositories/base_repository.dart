import 'package:quiz_u/core/utils/http_client.dart';

class BaseRepository {
  BaseRepository([HttpClient? httpClient])
      : httpClient = httpClient ?? HttpClient();

  late final HttpClient httpClient;
}
