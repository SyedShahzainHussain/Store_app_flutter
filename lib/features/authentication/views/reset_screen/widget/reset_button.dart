
import 'package:flutter/material.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/helper/helper_function.dart';
class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          THelperFunction.navigatedToScreenWithPop(context, const Login());
        },
        child: Text(TTexts.done.capitalize()),
      ),
    );
  }
}
