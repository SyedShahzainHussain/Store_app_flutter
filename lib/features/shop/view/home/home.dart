import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/favourite/favourite_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/fetch_products/fetch_products_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_event.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_event.dart';
import 'package:store/common/widgets/banners/t_banners.dart';
import 'package:store/common/widgets/text_field_container/text_field_container.dart';
import 'package:store/features/shop/view/allProducts/all_products.dart';
import 'package:store/features/shop/view/home/widget/categories_list.dart';
import 'package:store/features/shop/view/home/widget/home_app_bar.dart';
import 'package:store/common/widgets/container/t_primary_header_container.dart';
import 'package:store/features/shop/view/home/widget/product_list.dart';
import 'package:store/features/shop/view/home/widget/t_section_heading.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/constants/size.dart';
import 'package:store/utils/device/devices_utility.dart';
import 'package:store/utils/helper/helper_function.dart';
import 'package:store/utils/local_storage/storage_utility.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunction.isDarkMode(context);
    return Scaffold(
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
                const TTextFieldContainer(
                  text: "Search In Store",
                ),
                SizedBox(
                  height: TDeviceUtils.screenWidth(context) * 0.03,
                ),
                // ! Categories listview horizontal
                Padding(
                  padding: const EdgeInsets.only(left: TSized.defaultSpace),
                  child: TSectionHeading(
                    title: "Popular Categories",
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
            Padding(
              padding: const EdgeInsets.all(TSized.defaultSpace),
              child: Column(
                children: [
                  // ! CarouselSlider

                  const TBanners(),
                  const SizedBox(
                    height: TSized.spacebetweenItem,
                  ),

                  // ! Heading
                  TSectionHeading(
                    title: "Popular Products",
                    onPressed: () {
                      THelperFunction.navigatedToScreen(
                          context, const AllProducts());
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
