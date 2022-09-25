import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/ui/authentication/widgets/user_info.dart';
import 'package:quiz_u/ui/authentication/widgets/user_scores.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              AccountState.read(context).logout();
              await _storage.deleteAll();
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
