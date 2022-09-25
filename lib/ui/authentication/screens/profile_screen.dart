import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/ui/authentication/widgets/user_info.dart';
import 'package:quiz_u/ui/authentication/widgets/user_scores.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await LogoutCommand().execute();
                context.router.replaceAll(const [LoginRoute()]);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  ErrorSnackBar(content: Text(context.l10n.logoutFailed)),
                );
              }
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
