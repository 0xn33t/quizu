import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizState extends ChangeNotifier {
  static QuizState read(BuildContext context) => context.read<QuizState>();

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
}
