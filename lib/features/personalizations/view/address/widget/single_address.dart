import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/bloc/selected_address/selected_state.dart';
import 'package:store/common/widgets/container/t_rounded_container.dart';
import 'package:store/features/personalizations/model/address_model/address_model.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class SingleAddress extends StatelessWidget {
  final AddressModel selectedAddress;
  final void Function()? onTap;
  const SingleAddress(
      {super.key, required this.selectedAddress, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return BlocBuilder<SelectedAddressBloc, SelectedAddressState>(
      builder: (context, state) {
        
        return GestureDetector(
          onTap: onTap,
          child: TRoundedContainer(
            width: double.infinity,
            showBorder: true,
            padding: const EdgeInsets.all(TSized.md),
            backgroundColor: state.isAddressSeleted!.id! == selectedAddress.id
                ? TColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: state.isAddressSeleted!.id! == selectedAddress.id
                ? Colors.transparent
                : dark
                    ? TColors.darkerGrey
                    : TColors.grey,
            margin: const EdgeInsets.only(bottom: TSized.spacebetweenItem),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    state.isAddressSeleted!.id! == selectedAddress.id
                        ? Iconsax.tick_circle
                        : null,
                    size: 20,
                    color: state.isAddressSeleted!.id! == selectedAddress.id
                        ? dark
                            ? TColors.light
                            : TColors.dark
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedAddress.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: TSized.sm / 2,
                    ),
                    Text(
                      selectedAddress.phoneNumber,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: TSized.sm / 2,
                    ),
                     Text(
                      '${selectedAddress.postalCode} ${selectedAddress.street} ${selectedAddress.city} ${selectedAddress.country}',
                      softWrap: true,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
