import 'package:flutter/material.dart';
import 'package:store/utils/extension/language.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SignUpButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(context.localizations!.createAccount),
      ),
    );
  }
}
