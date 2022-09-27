import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/requests/login_request.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/utils/commands.dart';
import 'package:quiz_u/core/utils/validators.dart';
import 'package:quiz_u/ui/common/widgets/async_loader.dart';
import 'package:quiz_u/ui/common/widgets/loading_indicator.dart';
import 'package:quiz_u/ui/common/widgets/snack_bar_notifiers.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key, required this.mobile});

  final String mobile;

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  final _formKey = GlobalKey<FormState>();
  final _otp = TextEditingController();

  Future<void> _submit(AsyncLoaderState loaderState) async {
    final state = _formKey.currentState!;
    if (state.validate()) {
      state.save();
      try {
        loaderState.updateState();
        await LoginCommand().execute(
          LoginRequest(otp: _otp.text, mobile: widget.mobile),
        );
        if (!mounted) return;
        final state = AccountState.read(context);
        context.router.replaceAll(!state.isAccountCompleted
            ? const [CompleteAccountRoute()]
            : const [TabsRoute()]);
        loaderState.updateState();
      } catch (e) {
        loaderState.updateState();
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(content: Text(context.l10n.otpVerificationFailed)),
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
                activeColor: Theme.of(context).colorScheme.primary,
                activeFillColor: Colors.black26,
                selectedColor: Colors.black26,
                selectedFillColor: Colors.black26,
                inactiveColor: Colors.black26,
              ),
              validator: (value) {
                if (Validators.isEmpty(value)) return context.l10n.otpRequired;
                if (!Validators.isNumeric(value) || value!.length != 4) {
                  return context.l10n.invalidOtpFormat;
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
                      : Text(context.l10n.check),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
