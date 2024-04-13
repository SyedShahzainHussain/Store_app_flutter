import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/update_name/update_name_bloc.dart';
import 'package:store/bloc/update_name/update_name_event.dart';
import 'package:store/bloc/update_name/update_name_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/personalizations/view/profile/profile.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/constants/texts.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/popups/full_screen_loader.dart';
import 'package:store/utils/validator/validation.dart';

class ChangeName extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  const ChangeName(
      {super.key, required this.firstName, required this.lastName});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName ?? "";
    lastNameController.text = widget.lastName ?? "";
  }

  save() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
    context.read<UpdateNameBloc>().add(UpdateName(
        firstNameController.text.trim(), lastNameController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          "Change Name",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocListener<UpdateNameBloc, UpdateNameState>(
        listener: (context, state) {
          if (state is UpdateNameLoading) {
            TFullScreenLoader.openLoadingDialog(
              "We are updating your information...",
              TImageString.loaderJson,
            );
          } else if (state is UpdateNameFailed) {
            THelperFunction.showDelightToast(state.message);
          } else if (state is UpdateNameSuccess) {
            THelperFunction.navigatedToScreenWithPop(context, const ProfileScreen());
            THelperFunction.showDelightToast("Update Username");
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ! Heading
              Text(
                "Use real name for easy verification. This name will appear on several pages.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(
                height: TSized.spacebetweenItem,
              ),
              // ! Text field and Button
              Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        validator: (value) =>
                            TValidation.validateEmptyText(value, "First name"),
                        decoration: const InputDecoration(
                            labelText: TTexts.firstName,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                      const SizedBox(
                        height: TSized.spaceBtwInputFields,
                      ),
                      TextFormField(
                          controller: lastNameController,
                          validator: (value) =>
                              TValidation.validateEmptyText(value, "Last name"),
                          decoration: const InputDecoration(
                              labelText: TTexts.lastName,
                              prefixIcon: Icon(Iconsax.user))),
                    ],
                  )),
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
                    child: const Text("Save")),
              )
            ],
          ),
        ),
      ),
    );
  }
}