import 'package:flutter/material.dart';

// Renk sabitlerini tanımlayan singleton sınıfımız
class ColorConstants {
  static final ColorConstants _instance = ColorConstants._init();

  static ColorConstants get instance => _instance;

  ColorConstants._init();

  // Uygulamanın birincil rengi
  Color get primaryColor => Colors.lightBlueAccent;

  // Uygulamanın ikincil rengi
  Color get secondaryColor => Colors.blue;

  // Uygulamanın arka plan rengi
  Color get backgroundColor => Colors.white;
}
