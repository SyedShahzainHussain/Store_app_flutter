import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/register/register_bloc.dart';
import 'package:store/bloc/register/register_events.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/validator/validation.dart';
import 'package:store/features/authentication/views/signup/widget/sign_up_button.dart';
import 'package:store/features/authentication/views/signup/widget/sign_up_privacy.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController userName;
  late TextEditingController email;
  late TextEditingController phoneNumber;
  late TextEditingController password;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  ValueNotifier<bool> isCheck = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    firstName = TextEditingController();
    lastName = TextEditingController();
    userName = TextEditingController();
    email = TextEditingController();

    phoneNumber = TextEditingController();

    password = TextEditingController();
  }

  void onSave() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
    if (!isCheck.value) {
      THelperFunction.showDelightToast(
          "Agreement Required", Icons.error, Colors.red);
    } else {
      context.read<RegisterBloc>().add(SignUpEvents(
            email: email.text,
            firstName: firstName.text,
            lastName: lastName.text,
            password: password.text,
            phoneNumber: phoneNumber.text,
            userName: userName.text,
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);

    return Form(
      key: _form,
      child: Column(
        children: [
          // ! first and last name
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                validator: (value) => TValidation.validateEmptyText(
                  value,
                  TTexts.firstName,
                ),
                controller: firstName,
                expands: false,
                decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)),
              )),
              const SizedBox(width: TSized.spaceBtwInputFields),
              Expanded(
                  child: TextFormField(
                      controller: lastName,
                      validator: (value) => TValidation.validateEmptyText(
                            value,
                            TTexts.lastName,
                          ),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)))),
            ],
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          // ! username
          TextFormField(
            controller: userName,
            validator: (value) => TValidation.validateEmptyText(
              value,
              TTexts.userName,
            ),
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.userName,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          // ! email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) => TValidation.validateEmail(
              value,
            ),
            controller: email,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),

          // ! phoneNo
          TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) => TValidation.validatePhoneNumber(value),
            controller: phoneNumber,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 11,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: TSized.spaceBtwInputFields),
          //! Password
          ValueListenableBuilder(
            valueListenable: isObsecure,
            builder: (context, value, _) => TextFormField(
              validator: (value) =>
                  TValidation.validateEmptyText(value, TTexts.password),
              controller: password,
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
          // ! Terms and conditions
          SignUpPrivacy(
            isDark: isDark,
            isCheck: isCheck,
          ),
          const SizedBox(height: TSized.spacebetweenItem),
          // ! Sign up button
          SignUpButton(
            onPressed: () {
              onSave();
            },
          ),
        ],
      ),
    );
  }
}
