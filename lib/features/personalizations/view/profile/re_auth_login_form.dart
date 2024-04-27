import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/authentication/authentication_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/popups/full_screen_loader.dart';
import 'package:store/utils/validator/validation.dart';

class ReAuthLoginForm extends StatefulWidget {
  const ReAuthLoginForm({super.key});

  @override
  State<ReAuthLoginForm> createState() => _ReAuthLoginFormState();
}

class _ReAuthLoginFormState extends State<ReAuthLoginForm> {
  ValueNotifier<bool> isObsecure = ValueNotifier<bool>(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  save() {
    final validate = _form.currentState!.validate();
    if (!validate) return;
    context.read<AuthenticationBloc>().add(DeleteReAuthenticatedEvent(
        emailController.text.trim(), passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
         context.localizations!.reAuthenticatedUser,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is DeleteAccountLoading) {
            TFullScreenLoader.openLoadingDialog(
              "Processing ",
              TImageString.loaderJson,
            );
          } else if (state is DeleteAccountSuccess) {
            THelperFunction.navigatedToScreenWithPop(context, const Login());
          } else if (state is AuthenticationError) {
            THelperFunction.showDelightToast(state.message,Icons.error,Colors.red);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! Text field and Button
              Form(
                  key: _form,
                  child: Column(children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) => TValidation.validateEmail(value),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        hintText: context.localizations!.email,
                      ),
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    // ! Password
                    ValueListenableBuilder(
                      valueListenable: isObsecure,
                      builder: (context, value, _) => TextFormField(
                        controller: passwordController,
                        validator: (value) => TValidation.validateEmptyText(
                            value, TTexts.password),
                        obscuringCharacter: "*",
                        obscureText: isObsecure.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            icon: Icon(isObsecure.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                            onPressed: () {
                              isObsecure.value = !isObsecure.value;
                            },
                          ),
                          hintText: context.localizations!.password,
                        ),
                      ),
                    ),
                  ])),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      save();
                    },
                    child: Text(context.localizations!.verify)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
