import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_primary_header_container.dart';
import 'package:store/common/widgets/listtile/list_tile.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/personalizations/view/address/address.dart';
import 'package:store/features/personalizations/view/setting/widget/t_setting_menu_tile.dart';
import 'package:store/features/shop/view/cart/cart.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/orders/orders.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/helper/helper_function.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
      body: SingleChildScrollView(
          child: Column(
        children: [
          // ! Header
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              CustomAppBar(
                title: Text(
                  "Account",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                ),
              ),

              // ! User Profile Card
              const TUserProdileTile(),

              const SizedBox(
                height: TSized.spacebetweenSections,
              ),
            ],
          )),

          // ! Body
          Padding(
            padding: const EdgeInsets.all(TSized.defaultSpace),
            child: Column(
              children: [
                // ! Account Setting
                TSectionHeading(
                  title: "Account Settings",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                TSettingListTile(
                  icon: Iconsax.safe_home,
                  title: "My Address",
                  subTitle: "Set shoping delivery address",
                  onTap: () {
                    THelperFunction.navigatedToScreen(
                        context, const AddressScreen());
                  },
                ),
                TSettingListTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout",
                    onTap: () {
                      THelperFunction.navigatedToScreen(context, const CartScreen());
                    }),
                TSettingListTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subTitle: "In-progress and Completed Orders",
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context, const OrderScreen());
                    }),
                TSettingListTile(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subTitle: "Withdraw balance to registered bank account",
                    onTap: () {}),
                TSettingListTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subTitle: "List of all the discounted coupon",
                    onTap: () {}),
                TSettingListTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subTitle: "Set any kind of notification message",
                    onTap: () {}),
                TSettingListTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subTitle: "Manage dat usage and connected accounts",
                    onTap: () {}),

                // ! App Setting
                const SizedBox(
                  height: TSized.spacebetweenSections,
                ),
                TSectionHeading(
                  title: "App Settings",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                TSettingListTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subTitle: "Upload Data to your Cloud Firestore",
                    onTap: () {}),
                TSettingListTile(
                  icon: Iconsax.location,
                  title: "Geolocation",
                  subTitle: "Set recommendation based on location",
                  trailing: Switch(value: true, onChanged: (value) {}),
                  onTap: () {},
                ),
                TSettingListTile(
                  icon: Iconsax.security_user,
                  title: "Safe Mode",
                  subTitle: "Search result is safe for all ages",
                  trailing: Switch(value: false, onChanged: (value) {}),
                  onTap: () {},
                ),
                TSettingListTile(
                  icon: Iconsax.image,
                  title: "HD Image Quality",
                  subTitle: "Set image quality to be seen",
                  trailing: Switch(value: false, onChanged: (value) {}),
                  onTap: () {},
                ),
                // ! Logout Button
                const SizedBox(
                  height: TSized.spacebetweenItem,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {
                        AuthenticationRepository().logout();
                      },
                      child: const Text("Logout")),
                ),
                const SizedBox(
                  height: TSized.spacebetweenSections * 2.5,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
