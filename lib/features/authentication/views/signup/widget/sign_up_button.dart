import 'package:flutter/material.dart';
import 'package:store/features/authentication/views/verifyEmail/verify_email.dart';
import 'package:store/utils/helper/helper_function.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: const Text("Create Account"),
        onPressed: () {
          THelperFunction.navigatedToScreen(context, const VerifyEmail());
        },
      ),
    );
  }
}
