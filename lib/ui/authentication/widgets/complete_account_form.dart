import 'package:flutter/material.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/utils/validators.dart';
import 'package:quiz_u/ui/common/widgets/async_loader.dart';
import 'package:quiz_u/ui/common/widgets/loading_indicator.dart';

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

        loaderState.updateState();
      } catch (e) {
        loaderState.updateState();
        print(e.toString());
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
            decoration: InputDecoration(labelText: 'What\'s your name?'),
            keyboardType: TextInputType.text,
            validator: (value) =>
                Validators.isEmpty(value) ? 'Please enter your name' : null,
          ),
          AsyncLoaderProvider(
            consumer: AsyncLoaderConsumer(
              builder: (_, state, __) {
                return ElevatedButton(
                  onPressed: state.isLoading ? null : () => _submit(state),
                  child: state.isLoading
                      ? const LoadingIndicator(dimension: 20)
                      : Text('Done'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}