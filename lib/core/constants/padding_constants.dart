import 'package:flutter/material.dart';

import 'app_constants.dart';

// Padding sabitlerini tanımlayan singleton sınıfımız
class PaddingConstants {
  static final PaddingConstants _instance = PaddingConstants._init();

  static PaddingConstants get instance => _instance;

  PaddingConstants._init();

  // Getterlerimiz
  EdgeInsets get basePadding =>
      const EdgeInsets.all(AppConstants.basePaddingValue);
  EdgeInsets get lowTopPadding =>
      const EdgeInsets.only(top: AppConstants.lowTopPadding);
  EdgeInsets get lowAllPadding =>
      const EdgeInsets.all(AppConstants.lowAllPadding);
}
