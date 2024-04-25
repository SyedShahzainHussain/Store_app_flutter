import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/bloc/add_address/add_address_bloc.dart';
import 'package:store/bloc/add_order/add_order_bloc.dart';
import 'package:store/bloc/all_products/all_product_bloc.dart';
import 'package:store/bloc/authentication/authentication_bloc.dart';
import 'package:store/bloc/authentication/authentication_events.dart';
import 'package:store/bloc/brand/brand_bloc.dart';
import 'package:store/bloc/brand_products/brand_products_bloc.dart';
import 'package:store/bloc/cart_item/cart_item_bloc.dart';
import 'package:store/bloc/favourite/favourite_bloc.dart';
import 'package:store/bloc/favourite/favourite_event.dart';
import 'package:store/bloc/fetch_address/fetch_address_bloc.dart';
import 'package:store/bloc/fetch_banners/fetch_banners_bloc.dart';
import 'package:store/bloc/fetch_categories/fetch_categories_bloc.dart';
import 'package:store/bloc/fetch_orders/fetch_orders_bloc.dart';
import 'package:store/bloc/fetch_products/fetch_products_bloc.dart';
import 'package:store/bloc/fetch_sub_category/fetch_sub_category_bloc.dart';
import 'package:store/bloc/fetch_user/fetch_user_bloc.dart';
import 'package:store/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:store/bloc/google/google_bloc.dart';
import 'package:store/bloc/login/login_bloc.dart';
import 'package:store/bloc/register/register_bloc.dart';
import 'package:store/bloc/selected_address/selected_bloc.dart';
import 'package:store/bloc/selected_payment/selected_payment_bloc.dart';
import 'package:store/bloc/togglelist/togglelist_bloc.dart';
import 'package:store/bloc/update__detail_image/update_detail_image_bloc.dart';
import 'package:store/bloc/update_name/update_name_bloc.dart';
import 'package:store/bloc/upload_image/upload_image_bloc.dart';
import 'package:store/bloc/variation/variation_bloc.dart';
import 'package:store/bloc/verification/verification_bloc.dart';
import 'package:store/features/chatbot/bloc/post_chat_bot_api/post_chat_bot.bloc.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;
  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) =>
              AuthenticationBloc()..add(CheckAuthentication())),
      BlocProvider(create: (context) => RegisterBloc()),
      BlocProvider(create: (context) => VerificationBloc()),
      BlocProvider(create: (context) => LoginBloc()),
      BlocProvider(create: (context) => GoogleAuthBloc()),
      BlocProvider(create: (context) => ForgotPasswordBloc()),
      BlocProvider(create: (context) => FetchUserBloc()),
      BlocProvider(create: (context) => ViewModeBloc()),
      BlocProvider(create: (context) => UpdateNameBloc()),
      BlocProvider(create: (context) => UploadImageBloc()),
      BlocProvider(create: (context) => FetchCategoriesBloc()),
      BlocProvider(create: (context) => FetchBannersBloc()),
      BlocProvider(create: (context) => FetchProductsBloc()),
      BlocProvider(create: (context) => VariationBloc()),
      BlocProvider(
          create: (context) => UpdateDetailImageBloc(ProductModel.empty())),
      BlocProvider(create: (context) => AllProductBloc()),
      BlocProvider(create: (context) => BrandBloc()),
      BlocProvider(create: (context) => BrandProductsBloc()),
      BlocProvider(create: (context) => FetchSubCategoryBloc()),
      BlocProvider(create: (context) => FetchAddressBloc()),
      BlocProvider(create: (context) => AddAddressBloc()),
      BlocProvider(create: (context) => SelectedAddressBloc()),
      BlocProvider(create: (context) => CartItemBloc()),
      BlocProvider(
          create: (context) => FavouriteBloc()..add(GetAllFavourite())),
      BlocProvider(create: (context) => SelectedPaymentBloc()),
      BlocProvider(create: (context) => AddOrderBloc()),
      BlocProvider(create: (context) => FetchOrderBloc()),
      BlocProvider(create: (context) => PostChatBotBloc()),
    ], child: child);
  }
}
