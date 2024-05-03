import 'package:flutter/material.dart';
import 'package:store/bottom_navigation/bottom_navigtion.dart';
import 'package:store/common/widgets/brands/brands_porducts.dart';
import 'package:store/common/widgets/success_screen/success_screen.dart';
import 'package:store/features/authentication/views/forgotpassword/forgot_password.dart';
import 'package:store/features/authentication/views/login/login.dart';
import 'package:store/features/authentication/views/reset_screen/reset_screen.dart';
import 'package:store/features/authentication/views/signup/signup.dart';
import 'package:store/features/chatbot/view/chat_bot/chat_bot_screen.dart';
import 'package:store/features/personalizations/view/address/add_new__address_screen.dart';
import 'package:store/features/personalizations/view/address/address.dart';
import 'package:store/features/personalizations/view/profile/change_name.dart';
import 'package:store/features/personalizations/view/profile/profile.dart';
import 'package:store/features/personalizations/view/profile/re_auth_login_form.dart';
import 'package:store/features/shop/model/brand_model/brand_model.dart';
import 'package:store/features/shop/model/categories_model/categories_model.dart';
import 'package:store/features/shop/model/product_model/product_model.dart';
import 'package:store/features/shop/view/allBrands/all_brands.dart';
import 'package:store/features/shop/view/allProducts/all_products.dart';
import 'package:store/features/shop/view/cart/cart.dart';
import 'package:store/features/shop/view/checkout/checkout.dart';
import 'package:store/features/shop/view/orders/orders.dart';
import 'package:store/features/shop/view/product_rating/product_rating.dart';
import 'package:store/features/shop/view/produt_detail/product_details.dart';
import 'package:store/features/shop/view/subCategory/sub_category.dart';
import 'package:store/utils/routes/route_name.dart';

class AppRoutes {
  static Route<dynamic> onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      // !  login
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => const Login());
      // !  signup
      case RouteName.signUp:
        return MaterialPageRoute(builder: (context) => const SignUp());
      // !  forgot
      case RouteName.forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassword());
      // !  Add new address
      case RouteName.addNewAddressScreen:
        return MaterialPageRoute(
            builder: (context) => const AddNewAddressScreen());
      // !  Add new address
      case RouteName.reAuthLoginForm:
        return MaterialPageRoute(builder: (context) => const ReAuthLoginForm());
      // !  All Brand
      case RouteName.allBrandsScreen:
        return MaterialPageRoute(builder: (context) => const AllBrandsScreen());
      // !  Address Screen
      case RouteName.addressScreen:
        return MaterialPageRoute(builder: (context) => const AddressScreen());
      // !  Cart Screen
      case RouteName.cartScreen:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      // !  Order Screen
      case RouteName.orderScreen:
        return MaterialPageRoute(builder: (context) => const OrderScreen());
      // !  checkout Screen
      case RouteName.checkOutScreen:
        return MaterialPageRoute(builder: (context) => const CheckOutScreen());
      // !  Change Name
      case RouteName.changeName:
        final Map<String, String>? arguments =
            settings.arguments as Map<String, String>?;
        final String? firstName = arguments?['firstName'];
        final String? lastName = arguments?['lastName'];
        return MaterialPageRoute(
            builder: (context) => ChangeName(
                  firstName: firstName,
                  lastName: lastName,
                ));
      // !  Brand Products
      case RouteName.brandsProducts:
        final BrandModel brandModel = settings.arguments as BrandModel;
        return MaterialPageRoute(
            builder: (context) => BrandsProducts(
                  brandModel: brandModel,
                ));
      // !  Product Details
      case RouteName.productDetails:
        final ProductModel productModel = settings.arguments as ProductModel;
        return MaterialPageRoute(
            builder: (context) => ProductDetails(
                  productModel: productModel,
                ));

      // !  Bottom Navigation Screen
      case RouteName.bottomNavigationScreen:
        return MaterialPageRoute(
            builder: (context) => BottomNavigationScreen());
      // !  Success Screen
      case RouteName.successScreen:
        final Map<String, dynamic>? arguments =
            settings.arguments as Map<String, dynamic>?;
        final String? image = arguments?['image'];
        final String? subtitle = arguments?['subTitle'];
        final String? title = arguments?['title'];
        final void Function()? onPressed = arguments?['onPressed'];

        return MaterialPageRoute(
            builder: (context) => SuccessScreen(
                  image: image!,
                  onPressed: onPressed!,
                  subTitle: subtitle!,
                  title: title!,
                ));
      // !  All Products Screen
      case RouteName.allProducts:
        return MaterialPageRoute(builder: (context) => const AllProducts());
      // !  SubCategory Screen
      case RouteName.subCategory:
        final CategoryModel categoryModel = settings.arguments as CategoryModel;
        return MaterialPageRoute(
            builder: (context) => SubCategory(
                  categoryModel: categoryModel,
                ));
      // !  Chat Bot Screen
      case RouteName.chatBotScreen:
        return MaterialPageRoute(builder: (context) => const ChatBotScreen());
      // !  Product Rating Screen
      case RouteName.productRating:
        return MaterialPageRoute(builder: (context) => const ProductRating());
      // !  Profile Screen
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      // !  Reset Screen
      case RouteName.resetScreen:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ResetScreen(
                  email: email,
                ));

      default:
        return MaterialPageRoute(builder: (ctx) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
