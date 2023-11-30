import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../constants/scale_constants.dart';

class ApiService extends ChangeNotifier {
  //Hava Durumu Apisi Path
  final String weatherPath = 'forecast';
  //Şehirler Apisi Path
  final String cityPath = 'provinces';

  //Hava Durumu Apisinden Verileri Çeker
  Future<Map<String, dynamic>> _getWeatherData({
    required String temperatureUnit,
    required String latitude,
    required String longitude,
  }) async {
    final Map<String, String> queryParams = {
      'latitude': latitude,
      'longitude': longitude,
      'hourly': 'temperature_2m,weather_code',
      'current': 'temperature_2m,rain,weather_code,wind_speed_10m',
      'daily': 'temperature_2m_max,temperature_2m_min,weather_code,uv_index_max',
      'timezone': 'Europe/Istanbul',
      'temperature_unit': temperatureUnit,
    };
    final Uri uri =
        Uri.parse('${AppConstants.baseApiUrl}/$weatherPath').replace(
      queryParameters: queryParams,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Hava durumu datası alınırken hata oluştu!');
    }
  }

  //Celsius olarak çekmemizi sağlar
  Future<Map<String, dynamic>> getWeatherCelsius({
    required String latitude,
    required String longitude,
  }) async {
    return await _getWeatherData(
      temperatureUnit: ScaleConstants.celsius,
      latitude: latitude,
      longitude: longitude,
    );
  }
  //Fahrenheit olarak çekmemizi sağlar
  Future<Map<String, dynamic>> getWeatherFahrenheit({
    required String latitude,
    required String longitude,
  }) async {
    return await _getWeatherData(
      temperatureUnit: ScaleConstants.fahrenheit,
      latitude: latitude,
      longitude: longitude,
    );
  }

  //Şehir apimizden bütün şehirleri seçer
  Future<Map<String, dynamic>> getCityListData() async {
    final Uri uri = Uri.parse('${AppConstants.cityApiUrl}/$cityPath');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Şehir datası alınırken hata oluştu!');
    }
  }
}
