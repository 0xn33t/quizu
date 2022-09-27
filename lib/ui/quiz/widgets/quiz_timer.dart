import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/quiz_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/commands.dart';

class QuizTimer extends StatelessWidget {
  const QuizTimer({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: const BoxConstraints(minWidth: 80),
      padding: const EdgeInsets.symmetric(
          horizontal: AppEdges.large, vertical: AppEdges.small),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        borderRadius: AppCorners.largeBorderRadius,
      ),
      child: const TimerCountdown(countdown: Settings.quizDuration),
    );
  }
}

class TimerCountdown extends StatefulWidget {
  const TimerCountdown({super.key, required this.countdown});

  final Duration countdown;

  @override
  State<TimerCountdown> createState() => _TimerCountdownState();
}

class _TimerCountdownState extends State<TimerCountdown> {
  late Timer _timer;
  late Duration _countdown;

  @override
  void initState() {
    startQuizTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startQuizTimer() {
    const step = Duration(seconds: 1);
    _countdown = widget.countdown;
    _timer = Timer.periodic(step, (_) {
      setState(() {
        _countdown -= step;
        if (_countdown == Duration.zero) _quizIsUp();
      });
    });
  }

  void _quizIsUp() {
    _timer.cancel();
    final state = QuizState.read(context);
    RecordScoreCommand().execute(state.score);
    context.router.replace(QuizEndedRoute(completed: true, score: state.score));
  }

  String _timerDigits(int value) =>
      value.remainder(60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    if (!_timer.isActive) return const SizedBox();
    return Text(
      '${_timerDigits(_countdown.inMinutes)}:'
      '${_timerDigits(_countdown.inSeconds)}',
      style: Theme.of(context).textTheme.headline5,
      textAlign: TextAlign.center,
    );
  }
}
