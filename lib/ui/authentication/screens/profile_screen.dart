import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/authentication/widgets/user_info.dart';
import 'package:quiz_u/ui/authentication/widgets/user_scores.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              await LogoutCommand().execute();
              context.router.replaceAll(const [LoginRoute()]);
            },
            icon: const Icon(FlutterRemix.logout_circle_r_line),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UserInfo(),
          AppSpacers.verticalLarge,
          Expanded(child: UserScores()),
        ],
      ),
    );
  }
}
