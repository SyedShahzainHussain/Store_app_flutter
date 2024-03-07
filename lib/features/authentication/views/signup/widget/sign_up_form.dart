import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
    

    return Form(
      child: Column(
        children: [
          // ! first and last name
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              const SizedBox(width: TSized.spaceBtwInputFields),
              Expanded(
                  child: TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)))),
            ],
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          // ! username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          // ! email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),

          // ! phoneNo
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          //! Password
          ValueListenableBuilder(
            valueListenable: isObsecure,
            builder: (context, value, _) => TextFormField(
              obscuringCharacter: "*",
              obscureText: isObsecure.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon:
                      Icon(isObsecure.value ? Iconsax.eye_slash : Iconsax.eye),
                  onPressed: () {
                    isObsecure.value = !isObsecure.value;
                  },
                ),
                labelText: TTexts.password,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
