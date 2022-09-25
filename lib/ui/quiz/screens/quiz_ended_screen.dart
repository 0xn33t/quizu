import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';
import 'package:share_plus/share_plus.dart';

class QuizEndedScreen extends StatelessWidget {
  const QuizEndedScreen({super.key, required this.completed, this.score})
      : assert(!(completed && score == null),
            'Score value must be provided on completion');

  final bool completed;
  final int? score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quizEnded),
      ),
      body: completed ? _QuizCompleted(score: score!) : const _WrongAnswer(),
    );
  }
}

class _QuizCompleted extends StatelessWidget {
  const _QuizCompleted({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('You have completed'),
        Text(score.toString()),
        Text('correct answers!'),
        TextButton.icon(
          icon: const Icon(FlutterRemix.share_line),
          label: Text(context.l10n.share),
          onPressed: () async {
            try {
              await Share.share(context.l10n.shareResult(score.toString()));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackBar(content: Text(context.l10n.shareScoreFailed)),
              );
            }
          },
        ),
      ],
    );
  }
}

class _WrongAnswer extends StatelessWidget {
  const _WrongAnswer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.l10n.wrongAnswer),
        ElevatedButton(
          onPressed: () {
            context.router.replace(const QuizRoute());
          },
          child: Text(context.l10n.tryAgain),
        ),
      ],
    );
  }
}
