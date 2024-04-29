import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';
import 'package:store/utils/routes/page_transition.dart';
import 'package:store/utils/theme/custom_theme/app_bar_theme.dart';
import 'package:store/utils/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:store/utils/theme/custom_theme/check_box_theme.dart';
import 'package:store/utils/theme/custom_theme/chip_theme.dart';
import 'package:store/utils/theme/custom_theme/elevated_theme.dart';
import 'package:store/utils/theme/custom_theme/outlined_button_theme.dart';
import 'package:store/utils/theme/custom_theme/text_button_theme.dart';
import 'package:store/utils/theme/custom_theme/text_field_theme.dart';
import 'package:store/utils/theme/custom_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: PageTransition(),
    }),
    useMaterial3: true,
    scaffoldBackgroundColor: TColors.white,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    fontFamily: "Poppins",
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: TElevatedTheme.lightElevatedTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckTheme,
    chipTheme: TChipTheme.lightChipTheme,
    outlinedButtonTheme: TOutlinedTheme.lightOutlinedTheme,
    inputDecorationTheme: TFieldTheme.lightFieldTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: PageTransition(),
    }),
    useMaterial3: true,
    scaffoldBackgroundColor: TColors.black,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    fontFamily: "Poppins",
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: TElevatedTheme.darkElevatedTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckTheme,
    chipTheme: TChipTheme.darkChipTheme,
    outlinedButtonTheme: TOutlinedTheme.darkOutlinedTheme,
    inputDecorationTheme: TFieldTheme.darkFieldTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
  );
}
