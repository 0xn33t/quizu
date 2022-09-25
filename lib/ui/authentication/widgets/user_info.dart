import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/models/user.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
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
              Text('Name: ${result.name}'),
              Text('Mobile: ${result.mobile}'),
            ],
          );
        },
      ),
    );
  }
}
