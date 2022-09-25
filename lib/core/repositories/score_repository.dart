import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_u/core/config/endpoints.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/models/top_score.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/requests/record_score_request.dart';
import 'package:quiz_u/core/utils/http_client.dart';
import 'package:quiz_u/core/utils/response_exception.dart';

import 'base_repository.dart';

class ScoreRepository extends BaseRepository {
  ScoreRepository([HttpClient? httpClient]) : super(httpClient);

  final _storage = const FlutterSecureStorage();

  Future<bool> recordScore(RecordScoreRequest request) async {
    final res = await authorized(
      (token) => httpClient.request(
        options: HttpClientOptions(
          method: HttpClientMethod.post,
          endpoint: Endpoints.recordScore,
          body: request.toJson(),
          accessToken: token,
        ),
      ),
    );

    if (res.statusCode == HttpStatus.created) {
      return jsonDecode(res.body)['success'] == true;
    }
    return false;
  }

  Future<List<TopScore>> getTopScores() async {
    final res = await authorized(
      (token) => httpClient.request(
        options: HttpClientOptions(
          method: HttpClientMethod.get,
          endpoint: Endpoints.topScores,
          accessToken: token,
        ),
      ),
    );

    if (res.statusCode == HttpStatus.ok) {
      return TopScore.fromJsonList(jsonDecode(res.body));
    }
    throw ResponseExceptions.getTopScoresFailed;
  }

  Future<List<UserScore>> getScores() async {
    final userScores = await _storage.read(key: Settings.scoresStorageKey);
    return (userScores != null)
        ? UserScore.fromJsonList(jsonDecode(userScores)).reversed.toList()
        : [];
  }
}
