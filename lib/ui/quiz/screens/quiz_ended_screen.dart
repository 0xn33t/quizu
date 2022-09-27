import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/theme/styles.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(AppEdges.content),
        child: Center(
          child:
              completed ? _QuizCompleted(score: score!) : const _WrongAnswer(),
        ),
      ),
    );
  }
}

class _QuizCompleted extends StatelessWidget {
  const _QuizCompleted({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FlutterRemix.emotion_happy_line, size: 200),
        AppSpacers.verticalContent,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: context.l10n.youHaveCompleted,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                text: '( $score )',
                style: Theme.of(context).textTheme.headline2,
              ),
              TextSpan(text: context.l10n.correctAnswers),
            ],
          ),
        ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(FlutterRemix.emotion_unhappy_line, size: 200),
        AppSpacers.verticalContent,
        Text(
          context.l10n.wrongAnswer,
          style: Theme.of(context).textTheme.headline1,
        ),
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
