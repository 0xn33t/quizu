import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/datetime_utils.dart';

class UserScores extends StatelessWidget {
  const UserScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('My Scores'),
        AppSpacers.verticalContent,
        Selector<AccountState, List<UserScore>>(
          selector: (_, state) => state.scores,
          builder: (_, scores, __) {
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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppEdges.content,
        vertical: AppEdges.extraLarge,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(userScore.date.format('h:mm a d/M/y'))),
          AppSpacers.horizontalContent,
          Text(userScore.score.toString()),
        ],
      ),
    );
  }
}
