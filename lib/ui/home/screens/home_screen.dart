import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/theme/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quizU),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppEdges.content),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ready to test your knoweldge and challenge others?'),
            ElevatedButton(
              onPressed: () {
                context.router.push(const QuizRoute());
              },
              child: Text('Quiz Me!'),
            ),
            Text('Answer as much questions correctly within 2 minutes'),
          ],
        ),
      ),
    );
  }
}
