import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/models/top_score.dart';
import 'package:quiz_u/core/repositories/score_repository.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/ui/common/widgets/extended_future_builder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((AccountState s) => s.scores);
    print('build LeaderboardScreen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: ExtendedFutureBuilder<List<TopScore>>(
        future: ScoreRepository().getTopScores(),
        builder: (context, result) {
          return ListView.separated(
            itemCount: result.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, index) => TopScoreCard(topScore: result[index]),
          );
        },
      ),
    );
  }
}

class TopScoreCard extends StatelessWidget {
  const TopScoreCard({super.key, required this.topScore});

  final TopScore topScore;

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
          Expanded(child: Text(topScore.name)),
          AppSpacers.horizontalContent,
          Text(topScore.score.toString()),
        ],
      ),
    );
  }
}
