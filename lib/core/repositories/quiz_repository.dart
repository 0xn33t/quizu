import 'dart:convert';
import 'dart:io';

import 'package:quiz_u/core/config/endpoints.dart';
import 'package:quiz_u/core/models/question.dart';
import 'package:quiz_u/core/requests/record_score_request.dart';
import 'package:quiz_u/core/utils/http_client.dart';
import 'package:quiz_u/core/utils/response_exception.dart';

import 'base_repository.dart';

class QuizRepository extends BaseRepository {
  QuizRepository([HttpClient? httpClient]) : super(httpClient);

  Future<List<Question>> getQuestions() async {
    final res = await authorized(
      (token) => httpClient.request(
        options: HttpClientOptions(
          method: HttpClientMethod.get,
          endpoint: Endpoints.questions,
          accessToken: token,
        ),
      ),
    );

    if (res.statusCode == HttpStatus.ok) {
      return Question.fromJsonList(jsonDecode(res.body));
    }
    throw ResponseExceptions.getQuestionsFailed;
  }

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
}
