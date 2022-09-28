import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/theme/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.quizU),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppEdges.content),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.mainHeadlin1,
              style: themeData.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 65,
                color: themeData.colorScheme.primary,
              ),
            ),
            Text(
              context.l10n.mainHeadlin2,
              style: themeData.textTheme.headline2,
            ),
            AppSpacers.verticalExtraLarge,
            Text(
              context.l10n.mainHeadlin3,
              style: themeData.textTheme.bodyText1!,
            ),
            AppSpacers.verticalExtraLarge,
            ElevatedButton(
              onPressed: () => context.router.push(const QuizRoute()),
              child: Text(context.l10n.quizMe),
            ),
          ],
        ),
      ),
    );
  }
}
