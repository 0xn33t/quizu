import 'package:flutter/material.dart';
import 'package:quiz_u/core/index.dart';
import 'package:quiz_u/core/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();

  void _submit() {
    final state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      context.router.push(VerificationRoute(mobile: _mobile.text));
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
            controller: _mobile,
            decoration: InputDecoration(labelText: 'mobile number'),
            keyboardType: TextInputType.number,
            validator: (value) => Validators.isEmpty(value)
                ? 'Please enter your mobile number'
                : null,
          ),
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
