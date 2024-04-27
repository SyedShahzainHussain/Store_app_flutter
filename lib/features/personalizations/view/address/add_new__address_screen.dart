import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/add_address/add_address_bloc.dart';
import 'package:store/bloc/add_address/add_address_event.dart';
import 'package:store/bloc/add_address/add_address_state.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';
import 'package:store/utils/constants/image_strings.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/popups/full_screen_loader.dart';
import 'package:store/utils/validator/validation.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _form = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController stateCodeController = TextEditingController();

  void onSave() {
    final validate = _form.currentState!.validate();
    if (!validate) return;

    AddressModel addressModel = AddressModel(
      name: nameController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      street: streetController.text.trim(),
      city: cityController.text.trim(),
      country: countryController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      state: stateCodeController.text.trim(),
    );
    context.read<AddAddressBloc>().add(AddAddress(addressModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(context.localizations!.addNewAddress),
      ),
      body: BlocListener<AddAddressBloc, AddAddressState>(
        listener: (context, state) {
          if (state is AddAddressLoadingState) {
            TFullScreenLoader.openLoadingDialog(
              "Storing Address...",
              TImageString.loaderJson,
            );
          } else if (state is AddAddressErrorState) {
            THelperFunction.showDelightToast(
                state.message, Icons.error, Colors.red);
          } else {
            TFullScreenLoader.stopLoading();
            Navigator.pop(context);
            THelperFunction.showDelightToast(
                "Your address has been saved successfully",
                Iconsax.copy_success,
                Colors.green);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (value) => TValidation.validateEmptyText(
                          value, context.localizations!.name),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.user),
                          labelText: context.localizations!.name),
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      validator: (value) =>
                          TValidation.validatePhoneNumber(value),
                      maxLength: 11,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.mobile),
                          labelText: context.localizations!.phoneNo),
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: streetController,
                            validator: (value) => TValidation.validateEmptyText(
                                value, context.localizations!.street),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Iconsax.building_31),
                                labelText: context.localizations!.street),
                          ),
                        ),
                        const SizedBox(
                          width: TSized.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: postalCodeController,
                            validator: (value) => TValidation.validateEmptyText(
                                value, context.localizations!.postalCode),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Iconsax.code),
                                labelText: context.localizations!.postalCode),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cityController,
                            validator: (value) => TValidation.validateEmptyText(
                                value, context.localizations!.city),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Iconsax.building),
                                labelText: context.localizations!.city),
                          ),
                        ),
                        const SizedBox(
                          width: TSized.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: stateCodeController,
                            validator: (value) => TValidation.validateEmptyText(
                                value, context.localizations!.state),
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Iconsax.activity),
                                labelText: context.localizations!.state),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: countryController,
                      validator: (value) => TValidation.validateEmptyText(
                          value, context.localizations!.country),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.global),
                          labelText: context.localizations!.country),
                    ),
                    const SizedBox(
                      height: TSized.defaultSpace,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            onSave();
                          },
                          child: Text(context.localizations!.save)),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
