import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_event.dart';
import 'package:store/bloc/forgot_password/forgot_password_state.dart';
import 'package:store/utils/constants/extension.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/popups/full_screen_loader.dart';
import 'package:store/utils/routes/route_name.dart';
import 'package:store/utils/validator/validation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late TextEditingController emailController;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  save() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
    context
        .read<ForgotPasswordBloc>()
        .add(ForgotPasswordEvent(emailController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordLoading) {
              TFullScreenLoader.openLoadingDialog(
                "Logging you in...",
                TImageString.loaderJson,
              );
            } else if (state is ForgotPasswordError) {
              THelperFunction.showDelightToast(state.message);
            } else if (state is ForgotPasswordSuccess) {
              THelperFunction.navigatedToScreenWithPop(
                  context,
                  RouteName.resetScreen,
                  arguments:  state.email,
                );
              THelperFunction.showDelightToast("Forgot Password Email Send",Iconsax.copy_success,Colors.green);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ! Headings
                  Text(
                    context.localizations!.forgotPassTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),
                  Text(
                    context.localizations!.forgotPassSubTitle,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenSections * 2,
                  ),

                  // ! Form Text
                  TextFormField(
                      controller: emailController,
                      validator: (value) => TValidation.validateEmail(value),
                      decoration:  InputDecoration(
                          labelText: context.localizations!.email,
                          prefixIcon: const Icon(
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
                        save();
                      },
                      child: Text(context.localizations!.submit.capitalize()),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
