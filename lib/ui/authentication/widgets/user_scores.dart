import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/models/user_score.dart';
import 'package:quiz_u/core/repositories/score_repository.dart';
import 'package:quiz_u/core/utils/datetime_utils.dart';
import 'package:quiz_u/ui/common/widgets/extended_future_builder.dart';

class UserScores extends StatelessWidget {
  const UserScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('My Scores'),
        AppSpacers.verticalContent,
        ExtendedFutureBuilder<List<UserScore>>(
          future: ScoreRepository().getScores(),
          builder: (context, result) {
            return Expanded(
              child: ListView.separated(
                itemCount: result.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (_, index) =>
                    UserScoreCard(userScore: result[index]),
              ),
            );
          },
        )
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
