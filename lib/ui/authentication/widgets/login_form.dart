import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/states/account_state.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(content: Text('Invalid mobile number')),
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
          AppSpacers.verticalContent,
          ElevatedButton(
            onPressed: _submit,
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
