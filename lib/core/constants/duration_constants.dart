// Zaman sabitlerini tanımlayan singleton sınıfımız
import 'package:weather_app/core/constants/app_constants.dart';

class DurationConstants {
  static final DurationConstants _instance = DurationConstants._init();

  static DurationConstants get instance => _instance;

  DurationConstants._init();

  // Uzun süreli işlemler için getter.
  Duration get highDuration =>
      const Duration(milliseconds: AppConstants.millisecondsHigh);
}
