import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/top_score.dart';
import 'package:quiz_u/core/repositories/score_repository.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/ui/common/widgets/app_list_tile.dart';
import 'package:quiz_u/ui/common/widgets/extended_future_builder.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.select((AccountState s) => s.scores);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.leaderboard),
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
    return AppListTile(
      text: topScore.name,
      trailing: ListTileBadge(value: topScore.score.toString()),
    );
  }
}
