import 'package:flutter_dotenv/flutter_dotenv.dart';

// Uygulama sabitlerimiz
class AppConstants {
  //Uygulama ayarları
  static const String appName = 'Weather App';

  //API bilgileri
  static String baseApiUrl = dotenv.env['BASE_API_URL'] ?? '';
  static String cityApiUrl = dotenv.env['CITY_API_URL'] ?? '';

  //Sabit ayarları
  static const int millisecondsHigh = 1000;
  static const double basePaddingValue = 16.0;
  static const double lowTopPadding = 8.0;
  static const double lowAllPadding = 8.0;
}
