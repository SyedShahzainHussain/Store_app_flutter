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
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
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
                      validator: (value) =>
                          TValidation.validateEmptyText(value, "Name"),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user), labelText: "Name"),
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
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.mobile),
                          labelText: "Phone Number"),
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: streetController,
                            validator: (value) =>
                                TValidation.validateEmptyText(value, "Street"),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: "Street"),
                          ),
                        ),
                        const SizedBox(
                          width: TSized.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: postalCodeController,
                            validator: (value) => TValidation.validateEmptyText(
                                value, "Postal Code"),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: "Postal Code"),
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
                            validator: (value) =>
                                TValidation.validateEmptyText(value, "City"),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: "City"),
                          ),
                        ),
                        const SizedBox(
                          width: TSized.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: stateCodeController,
                            validator: (value) =>
                                TValidation.validateEmptyText(value, "State"),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: "State"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSized.spaceBtwInputFields,
                    ),
                    TextFormField(
                      controller: countryController,
                      validator: (value) =>
                          TValidation.validateEmptyText(value, "Country"),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.global),
                          labelText: "Country"),
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
                          child: const Text("Save")),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
