import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/user.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/ui/common/widgets/extended_future_builder.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppEdges.content,
        vertical: AppEdges.extraLarge,
      ),
      child: ExtendedFutureBuilder<User>(
        future: AccountRepository().getUser(),
        builder: (context, result) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${context.l10n.name}: ${result.name}'),
              Text('${context.l10n.mobileNumber}: ${result.mobile}'),
            ],
          );
        },
      ),
    );
  }
}
