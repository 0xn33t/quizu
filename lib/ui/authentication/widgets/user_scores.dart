import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/datetime_utils.dart';
import 'package:quiz_u/ui/common/widgets/app_list_tile.dart';

class UserScores extends StatelessWidget {
  const UserScores({super.key});

  @override
  Widget build(BuildContext context) {
    const contentPadding = EdgeInsets.symmetric(
      horizontal: AppEdges.content,
      vertical: AppEdges.large,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: contentPadding,
          child: Text(
            context.l10n.myScores,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Selector<AccountState, List<UserScore>>(
          selector: (_, state) => state.scores,
          builder: (_, scores, __) {
            if (scores.isEmpty) {
              return Padding(
                padding: contentPadding,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: context.l10n.noScores,
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: context.l10n.startAQuiz,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(const QuizRoute());
                          },
                      ),
                      TextSpan(text: context.l10n.toTestKnowledge),
                    ],
                  ),
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                itemCount: scores.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) =>
                    UserScoreCard(userScore: scores[index]),
              ),
            );
          },
        ),
      ],
    );
  }
}

class UserScoreCard extends StatelessWidget {
  const UserScoreCard({super.key, required this.userScore});

  final UserScore userScore;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      text: userScore.date.format('h:mm a d/M/y'),
      trailing: ListTileBadge(value: userScore.score.toString()),
    );
  }
}
