import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_event.dart';
import 'package:store/bloc/favourite/favourite_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/fetch_products/fetch_products_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_event.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_event.dart';
import 'package:store/common/widgets/banners/t_banners.dart';
import 'package:store/common/widgets/text_field_container/text_field_container.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_bloc.dart';
import 'package:store/features/personalizations/bloc/change_language/change_language_event.dart';
import 'package:store/features/shop/view/home/widget/categories_list.dart';
import 'package:store/features/shop/view/home/widget/home_app_bar.dart';
import 'package:store/common/widgets/container/t_primary_header_container.dart';
import 'package:store/features/shop/view/home/widget/product_list.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/extension/language.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/local_storage/storage_utility.dart';
import 'package:store/utils/routes/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // ! fetch user
    context.read<FetchUserBloc>().add(FetchUser());
    // ! fetch products
    context.read<FetchProductsBloc>().add(GetProductsEvent());
    // ! Fetch Wishlist And Also add user id to storage container
    LocalStorage.init(FirebaseAuth.instance.currentUser!.uid).then((value) {
      context.read<FavouriteBloc>().add(GetAllFavourite());
      context.read<CartItemBloc>().add(LoadCartItem());
      context.read<ChangeLanguageBloc>().add(FetchLanguage());
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    final localization = Localizations.localeOf(context);
    return  Scaffold(
       
        body: SingleChildScrollView(
          child: Column(
            children: [
              // ! Header
              TPrimaryHeaderContainer(
                  child: Column(
                children: [
                  // ! Home App Bar
                  const HomeAppBar(),
                  SizedBox(
                    height: TDeviceUtils.screenWidth(context) * 0.03,
                  ),
                  // ! Search Text Field
                  TTextFieldContainer(
                    text: context.localizations!.searchInStore,
                  ),
                  SizedBox(
                    height: TDeviceUtils.screenWidth(context) * 0.03,
                  ),
                  // ! Categories listview horizontal
                  Padding(
                    padding: EdgeInsets.only(
                      left: localization.languageCode == "en"
                          ? TSized.defaultSpace
                          : 0.0,
                      right: localization.languageCode == "en"
                          ? 0.0
                          : TSized.defaultSpace,
                    ),
                    child: TSectionHeading(
                      title: context.localizations!.popularCategory,
                      showActionButton: false,
                      textColor: isDark ? TColors.black : TColors.white,
                    ),
                  ),
                  SizedBox(
                    height: TDeviceUtils.screenWidth(context) * 0.05,
                  ),
                  // ! Categories
                  const CategoriesList(),
                  const SizedBox(
                    height: TSized.spacebetweenSections,
                  )
                ],
              )),
              // ! Main
              // ! CarouselSlider
              // ! Heading
              Padding(
                padding: const EdgeInsets.all(TSized.defaultSpace),
                child: Column(
                  children: [
                    TSectionHeading(
                      title: context.localizations!.swipeYourChoice,
                      showActionButton: false,
                    ),
                    const TBanners(),
                    const SizedBox(
                      height: TSized.spacebetweenItem,
                    ),
    
                    // ! Heading
                    TSectionHeading(
                      buttontitle: context.localizations!.viewAll,
                      title: context.localizations!.popularProducts,
                      onPressed: () {
                        THelperFunction.navigatedToScreen(
                            context, RouteName.allProducts);
                      },
                    ),
    
                    // ! Products List
                    const ProductsList()
                  ],
                ),
              )
            ],
          ),
        ),
      
    );
  }
}
