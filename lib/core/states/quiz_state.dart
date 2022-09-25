import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/config/index.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/repositories/score_repository.dart';
import 'package:quiz_u/core/requests/record_score_request.dart';

class QuizState extends ChangeNotifier {
  static QuizState read(BuildContext context) => context.read<QuizState>();

  final _storage = const FlutterSecureStorage();
  final _scoreRepository = ScoreRepository();

  final _pageController = PageController(initialPage: 0, keepPage: true);
  PageController get pageController => _pageController;

  int _score = 0;
  int get score => _score;

  bool _skipped = false;
  bool get skipped => _skipped;

  void onScore([bool isLast = false]) {
    _score++;
    if (!isLast) _moveNext();
  }

  void onSkip() {
    _skipped = true;
    _moveNext();
    notifyListeners();
  }

  void _moveNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Future<void> recordUserScore() async {
    try {
      final userScores = await _storage.read(key: Settings.scoresStorageKey);
      List<UserScore> scores = [];
      if (userScores != null) {
        final userScoresList = UserScore.fromJsonList(jsonDecode(userScores));
        scores.addAll(userScoresList);
      }
      scores.add(UserScore(date: DateTime.now(), score: score));
      await _storage.write(
        key: Settings.scoresStorageKey,
        value: jsonEncode(scores),
      );
      await _scoreRepository.recordScore(
        RecordScoreRequest(score: score.toString()),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
