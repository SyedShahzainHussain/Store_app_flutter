import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/utils/constants/size.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text("Add new Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user), labelText: "Name"),
              ),
              const SizedBox(
                height: TSized.spaceBtwInputFields,
              ),
              TextFormField(
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
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global), labelText: "Country"),
              ),
              const SizedBox(
                height: TSized.defaultSpace,
              ),
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text("Save")),)
            ],
          )),
        ),
      ),
    );
  }
}
