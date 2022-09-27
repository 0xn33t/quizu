import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/phone_number_utils.dart';
import 'package:quiz_u/ui/common/widgets/mobile_form_field.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneNumberUtils = PhoneNumberUtils();
  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();

  Future<void> _submit() async {
    final state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      try {
        final regionCode = AccountState.read(context).regionCode;
        final isValidMobile = await _phoneNumberUtils.validate(
          _mobile.text,
          regionCode: regionCode,
        );
        final parsedMobile =
            await _phoneNumberUtils.parse(_mobile.text, regionCode: regionCode);
        if (isValidMobile && parsedMobile != null) {
          context.router.push(VerificationRoute(mobile: parsedMobile.e164));
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(content: Text(context.l10n.mobileNumberInvalid)),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(content: Text(context.l10n.loginFailed)),
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
          MobileFormField(controller: _mobile),
          AppSpacers.verticalMedium,
          ElevatedButton(
            onPressed: _submit,
            child: Text(context.l10n.start),
          ),
        ],
      ),
    );
  }
}
