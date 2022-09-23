import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/routing/app_router.dart';

class QuizEndedScreen extends StatelessWidget {
  const QuizEndedScreen({super.key, required this.completed, this.score})
      : assert(!(completed && score == null),
            'Scroe value must be provided on completion');

  final bool completed;
  final int? score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Ended'),
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
          label: Text('Share'),
          onPressed: () {},
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
        Text('Wrong Answer'),
        ElevatedButton(
          onPressed: () {
            context.router.replace(const QuizRoute());
          },
          child: Text('Try Again'),
        ),
      ],
    );
  }
}
