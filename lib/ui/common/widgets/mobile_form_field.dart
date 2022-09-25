import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/core/l10n/l10n.dart';
import 'package:quiz_u/core/models/country.dart';
import 'package:quiz_u/core/routing/app_router.dart';
import 'package:quiz_u/core/states/account_state.dart';
import 'package:quiz_u/core/theme/styles.dart';
import 'package:quiz_u/core/utils/validators.dart';

class MobileFormField extends StatelessWidget {
  const MobileFormField({super.key, this.controller, this.validator});

  final TextEditingController? controller;
  final FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: context.l10n.mobileNumber,
        prefixIcon: const DialCodeSelector(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (Validators.isEmpty(value)) return context.l10n.mobileNumberRequired;
        return validator?.call(value);
      },
    );
  }
}

class DialCodeSelector extends StatelessWidget {
  const DialCodeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppEdges.content),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Selector<AccountState, Country?>(
            selector: (_, state) => state.deviceCountry,
            builder: (_, country, __) {
              if (country != null) {
                return GestureDetector(
                  onTap: () {
                    context.router.push(CountrySelectorRoute(
                      onSelected: (country) {
                        AccountState.read(context)
                            .setDeviceRegionCode(country.code);
                        context.router.pop();
                      },
                    ));
                  },
                  child: Wrap(
                    children: [
                      Text(
                        country.flag,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      AppSpacers.horizontalSmall,
                      Transform(
                        transform: Matrix4.translationValues(0, 2.5, 0),
                        child: Text(country.dialCode),
                      ),
                      const Icon(FlutterRemix.arrow_drop_down_line),
                    ],
                  ),
                );
              }
              return const Icon(FlutterRemix.more_2_fill);
            },
          )
        ],
      ),
    );
  }
}
