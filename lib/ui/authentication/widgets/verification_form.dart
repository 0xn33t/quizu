import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz_u/core/config/settings.dart';
import 'package:quiz_u/core/models/account.dart';
import 'package:quiz_u/core/repositories/account_repository.dart';
import 'package:quiz_u/core/requests/login_request.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/validators.dart';
import 'package:quiz_u/ui/common/widgets/async_loader.dart';
import 'package:quiz_u/ui/common/widgets/loading_indicator.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key, required this.mobile});

  final String mobile;

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  final _accountRepository = AccountRepository();
  final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController();

  Future<void> _submit(AsyncLoaderState loaderState) async {
    final state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      try {
        loaderState.updateState();
        final res = await _accountRepository.login(
          LoginRequest(otp: _otp.text, mobile: widget.mobile),
        );
        if (!mounted) return;
        final account = Account(token: res.token);
        AccountState.read(context).setAccount(account);
        await _storage.write(
          key: Settings.authStorageKey,
          value: jsonEncode(account),
        );
        context.router.replaceAll((res.isNewUser || !res.isNameSet)
            ? const [CompleteAccountRoute()]
            : const [TabsRoute()]);
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
          Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              onCompleted: (value) {},
              appContext: context,
              controller: _otp,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              length: 4,
              animationType: AnimationType.fade,
              textStyle: const TextStyle(fontSize: 30),
              keyboardType: TextInputType.number,
              errorTextSpace: 30,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
              ),
              validator: (value) {
                if (Validators.isEmpty(value)) {
                  return 'Otp is required';
                }
                if (!Validators.isNumeric(value) || value!.length != 4) {
                  return 'Invalid otp format';
                }
                return null;
              },
              onChanged: (value) {},
            ),
          ),
          AsyncLoaderProvider(
            consumer: AsyncLoaderConsumer(
              builder: (_, state, __) {
                return ElevatedButton(
                  onPressed: state.isLoading ? null : () => _submit(state),
                  child: state.isLoading
                      ? const LoadingIndicator(dimension: 20)
                      : Text('Check'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
