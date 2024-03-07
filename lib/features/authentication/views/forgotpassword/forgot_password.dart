import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/features/authentication/views/reset_screen/reset_screen.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSized.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ! Headings
            Text(
              TTexts.forgotPassTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: TSized.spacebetweenItem,
            ),
            Text(
              TTexts.forgotPassSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSized.spacebetweenSections * 2,
            ),

            // ! Form Text
            TextFormField(
                decoration: const InputDecoration(
                    labelText: TTexts.email,
                    prefixIcon: Icon(
                      Iconsax.direct_right,
                    ))),
            const SizedBox(
              height: TSized.spacebetweenSections,
            ),

            // ! Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  THelperFunction.navigatedToScreen(context, const ResetScreen());
                },
                child: Text(TTexts.submit.capitalize()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
