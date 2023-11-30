import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

final ColorConstants colorConstants = ColorConstants.instance;

//Tema dosyamız
class AppTheme {
  static ThemeData theme = ThemeData(
      primaryColor: colorConstants.primaryColor,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: colorConstants.secondaryColor),
      scaffoldBackgroundColor: colorConstants.backgroundColor,
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: colorConstants.primaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorConstants.primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black));
}
