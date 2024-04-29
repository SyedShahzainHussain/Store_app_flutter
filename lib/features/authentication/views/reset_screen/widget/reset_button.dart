import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_event.dart';

import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/routes/route_name.dart';

class ResetButton extends StatelessWidget {
  final String email;
  const ResetButton({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              THelperFunction.navigatedToScreenWithPop(context, RouteName.login);
            },
            child: Text(context.localizations!.done.capitalize()),
          ),
        ),
        const SizedBox(
          height: TSized.spacebetweenItem,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              context
                  .read<ForgotPasswordBloc>()
                  .add(ForgotPasswordResentEmailEvent(email));
            },
            child: Text(context.localizations!.resendEmail.capitalize()),
          ),
        ),
      ],
    );
  }
}
