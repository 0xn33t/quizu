import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/question.dart';
import 'package:quiz_u/core/states/quiz_state.dart';
import 'question_card.dart';

class QuestionsList extends StatelessWidget {
  const QuestionsList({super.key, required this.questions});

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const NeverScrollableScrollPhysics(),
      controller: context.read<QuizState>().pageController,
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return QuestionCard(
          question: questions[index],
          isLast: index == questions.length - 1,
          meta: Text(
            '${index + 1} ${context.l10n.ofV} ${questions.length}',
            style: Theme.of(context).textTheme.headline5,
          ),
        );
      },
    );
  }
}
