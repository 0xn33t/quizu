import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/requests/update_user_request.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/validators.dart';
import 'package:quiz_u/ui/common/widgets/async_indicators.dart';
import 'package:quiz_u/ui/common/widgets/async_loader.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

class CompleteAccountForm extends StatefulWidget {
  const CompleteAccountForm({super.key});

  @override
  State<CompleteAccountForm> createState() => CompleteAccountFormState();
}

class CompleteAccountFormState extends State<CompleteAccountForm> {
  final _accountRepository = AccountRepository();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();

  Future<void> _submit(AsyncLoaderState loaderState) async {
    final state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      try {
        loaderState.updateState();
        await _accountRepository
            .updateUser(UpdateUserRequest(name: _name.text));
        if (!mounted) return;
        context.router.replaceAll(const [TabsRoute()]);
        loaderState.updateState();
      } catch (e) {
        loaderState.updateState();
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(content: Text(context.l10n.completeAccountFailed)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _name,
            decoration: InputDecoration(labelText: context.l10n.yourName),
            keyboardType: TextInputType.text,
            validator: (value) =>
                Validators.isEmpty(value) ? context.l10n.nameRequired : null,
          ),
          AppSpacers.verticalMedium,
          AsyncLoaderProvider(
            consumer: AsyncLoaderConsumer(
              builder: (_, state, __) {
                return ElevatedButton(
                  onPressed: state.isLoading ? null : () => _submit(state),
                  child: state.isLoading
                      ? const LoadingIndicator(dimension: 20)
                      : Text(context.l10n.done),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
