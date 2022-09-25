import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/models/question.dart';
import 'package:quiz_u/core/states/quiz_state.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

typedef OnChoiceClicked = void Function(BuildContext context, String choice);

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question, this.isLast = false});

  final Question question;
  final bool isLast;

  void _onChoiceClicked(BuildContext context, String choice) {
    if (question.isCorrectAnswer(choice)) {
      final state = context.read<QuizState>();
      state.onScore(isLast);
      if (isLast) {
        try {
          RecordScoreCommand().execute(state.score);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackBar(content: Text(context.l10n.recordScoreFailed)),
          );
        }
        context.router
            .replace(QuizEndedRoute(completed: true, score: state.score));
      }
    } else {
      context.router.replace(QuizEndedRoute(completed: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question.question),
        AppSpacers.verticalContent,
        ...question.choices
            .map((entry) =>
                QuestionChoice(entry: entry, onChoiceClicked: _onChoiceClicked))
            .toList(),
        AppSpacers.verticalContent,
        Selector<QuizState, bool>(
          selector: (_, state) => state.skipped,
          builder: (_, skipped, __) {
            if (skipped) return const SizedBox();
            return ElevatedButton(
              onPressed: () {
                QuizState.read(context).onSkip();
              },
              child: Text(context.l10n.skip),
            );
          },
        ),
      ],
    );
  }
}

class QuestionChoice extends StatelessWidget {
  const QuestionChoice(
      {super.key, required this.entry, required this.onChoiceClicked});

  final MapEntry<String, String> entry;
  final OnChoiceClicked onChoiceClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChoiceClicked.call(context, entry.key),
      child: Container(
        padding: const EdgeInsets.all(AppEdges.content),
        margin: const EdgeInsets.only(bottom: AppEdges.content),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: AppCorners.largeBorderRadius,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Text(entry.key)),
            ),
            AppSpacers.horizontalContent,
            Expanded(child: Text(entry.value)),
          ],
        ),
      ),
    );
  }
}
