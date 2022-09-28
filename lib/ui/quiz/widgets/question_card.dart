import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/question.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/quiz_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/common/widgets/app_decorated_box.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

typedef OnChoiceClicked = void Function(BuildContext context, String choice);

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.meta,
    this.isLast = false,
  });

  final Question question;
  final bool isLast;
  final Widget meta;

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppEdges.content),
      child: AppDecoratedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppEdges.small),
              child: meta,
            ),
            Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            AppSpacers.verticalContent,
            ...question.choices
                .map((entry) => QuestionChoice(
                    entry: entry, onChoiceClicked: _onChoiceClicked))
                .toList(),
          ],
        ),
      ),
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
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onChoiceClicked.call(context, entry.key),
      child: AppDecoratedContainer(
        radius: 20,
        padding: const EdgeInsets.all(AppEdges.small),
        margin: const EdgeInsets.only(bottom: AppEdges.content),
        color: theme.colorScheme.primary.withOpacity(0.05),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: AppDecoratedContainer(
                shape: BoxShape.circle,
                child: Center(
                  child: Text(
                    entry.key,
                    style: theme.textTheme.headline6!,
                  ),
                ),
              ),
            ),
            AppSpacers.horizontalContent,
            Expanded(child: Text(entry.value)),
          ],
        ),
      ),
    );
  }
}
