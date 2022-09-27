import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/user.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/styles.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AccountState, User?>(
      selector: (_, state) => state.user,
      builder: (_, user, __) {
        if (user != null) {
          return Container(
            color: Colors.black.withOpacity(0.08),
            padding: const EdgeInsets.symmetric(
              horizontal: AppEdges.content,
              vertical: AppEdges.extraLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('${context.l10n.name}: ${user.name ?? ''}'),
                Text('${context.l10n.mobileNumber}: ${user.mobile}'),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
