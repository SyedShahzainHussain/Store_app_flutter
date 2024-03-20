import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/layouts/grid_layout.dart';
import 'package:store/common/widgets/products/t_cart_products_vertical.dart';
import 'package:store/utils/constants/size.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("Popular Products"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSized.defaultSpace),
          child: Column(
            children: [
              // ! Dropdown
              DropdownButtonFormField(
                  decoration:
                      const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                  hint: const Text("Filter Products"),
                  items: [
                    'Name',
                    'Higher Price',
                    'Lower Price',
                    'Sale',
                    'Newest',
                    'Popularity'
                  ]
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (newValue) {}),

              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
              GridLayout(
                  itemBuilder: (_, index) => const TProductCartVertical(),
                  itemCount: 10)
            ],
          ),
        ),
      ),
    );
  }
}
