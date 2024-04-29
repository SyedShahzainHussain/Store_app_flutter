import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:store/bottom_navigtion.dart';
import 'package:store/common/widgets/appBar/app_bar.dart';
import 'package:store/common/widgets/container/t_primary_header_container.dart';
import 'package:store/common/widgets/listtile/list_tile.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_bloc.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_event.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_state.dart';
import 'package:store/features/personalizations/view/address/address.dart';
import 'package:store/features/personalizations/view/setting/widget/t_setting_menu_tile.dart';
import 'package:store/features/shop/view/cart/cart.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/features/shop/view/orders/orders.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          THelperFunction.isDarkMode(context) ? TColors.black : TColors.white,
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            THelperFunction.navigatedToScreenWithPop(
                context, const BottomNavigationScreen());
          }
        },
        child: SingleChildScrollView(
            child: Column(
          children: [
            // ! Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                CustomAppBar(
                  title: Text(
                    context.localizations!.account,
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
                    title: context.localizations!.accountSetting,
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),
                  TSettingListTile(
                    icon: Iconsax.safe_home,
                    title: context.localizations!.myAddress,
                    subTitle: context.localizations!.setShoppingDeliveryAddress,
                    onTap: () {
                      THelperFunction.navigatedToScreen(
                          context, const AddressScreen());
                    },
                  ),
                  TSettingListTile(
                      icon: Iconsax.shopping_cart,
                      title: context.localizations!.myCart,
                      subTitle: context.localizations!.addRemoveProduct,
                      onTap: () {
                        THelperFunction.navigatedToScreen(
                            context, const CartScreen());
                      }),
                  TSettingListTile(
                      icon: Iconsax.bag_tick,
                      title: context.localizations!.myOrders,
                      subTitle: context.localizations!.inProgress,
                      onTap: () {
                        THelperFunction.navigatedToScreen(
                            context, const OrderScreen());
                      }),
                  TSettingListTile(
                      icon: Iconsax.bank,
                      title: context.localizations!.bankAccount,
                      subTitle: context.localizations!.withDrawAccount,
                      onTap: () {}),
                  TSettingListTile(
                      icon: Iconsax.discount_shape,
                      title: context.localizations!.myCoupons,
                      subTitle: context.localizations!.discountCoupons,
                      onTap: () {}),
                  TSettingListTile(
                      icon: Iconsax.notification,
                      title: context.localizations!.notification,
                      subTitle: context.localizations!.notificationMessage,
                      onTap: () {}),
                  TSettingListTile(
                      icon: Iconsax.security_card,
                      title: context.localizations!.accountPrivacy,
                      subTitle: context.localizations!.accountPrivacyMessage,
                      onTap: () {}),

                  // ! App Setting
                  const SizedBox(
                    height: TSized.spacebetweenSections,
                  ),
                  TSectionHeading(
                    title: context.localizations!.appSetting,
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),

                  TSettingListTile(
                      icon: Iconsax.document_upload,
                      title: context.localizations!.loadData,
                      subTitle: context.localizations!.uplaodData,
                      onTap: () {}),
                  BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                    builder: (context, state) {
                      return TSettingListTile(
                          icon: Icons.mark_chat_unread,
                          title: context.localizations!.language,
                          subTitle: context.localizations!.changeLanguage,
                          trailing: ToggleSwitch(
                            minWidth: 50,
                            minHeight: 30,
                            cornerRadius: 20.0,
                            fontSize: 10,
                            activeBgColors: const [
                              [TColors.primary],
                              [TColors.primary],
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.black,
                            inactiveFgColor: Colors.white,
                            initialLabelIndex:
                                state.appLocale == const Locale("en") ? 0 : 1,
                            totalSwitches: 2,
                            labels: const ['Eng', 'Urdu'],
                            radiusStyle: true,
                            onToggle: (index) => context
                                .read<ChangeLanguageBloc>()
                                .add(ChangeLanguage(index!)),
                          ),
                          onTap: null);
                    },
                  ),
                  TSettingListTile(
                    icon: Iconsax.location,
                    title: context.localizations!.geoLocation,
                    subTitle: context.localizations!.geoLocationMessage,
                    trailing: Switch(value: true, onChanged: (value) {}),
                    onTap: () {},
                  ),
                  TSettingListTile(
                    icon: Iconsax.security_user,
                    title: context.localizations!.safeMode,
                    subTitle: context.localizations!.safeModeMessage,
                    trailing: Switch(value: false, onChanged: (value) {}),
                    onTap: () {},
                  ),
                  TSettingListTile(
                    icon: Iconsax.image,
                    title: context.localizations!.hdImageQuality,
                    subTitle: context.localizations!.hdImageQualityMessage,
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
                        child: Text(context.localizations!.logout)),
                  ),
                  const SizedBox(
                    height: TSized.spacebetweenSections * 2.5,
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
