import 'package:flutter/foundation.dart';

import '../../../core/models/city_model.dart';
import '../../../core/models/weather_model.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/permission_service.dart';

//
//İzin alınamassa veya bir sorun oluşursa Ankara yı gösterir.
//

class HomeViewModel extends ChangeNotifier {
  final ApiService apiService = ApiService();
  final PermissionService _permissionService = PermissionService();

  HomeViewModel() {
    _init();
  }

  _init() async {
    await _fetchCityListData();
    _checkPermission();
  }

  WeatherModel? _celsiusWeather;
  WeatherModel? _fahrenheitWeather;
  String? _city;
  List<CityModel>? _cityList;

  //Getterlerimiz
  WeatherModel? get celsiusWeather => _celsiusWeather;
  WeatherModel? get fahrenheitWeather => _fahrenheitWeather;
  String? get city => _city;
  List<CityModel>? get cityList => _cityList;
  CityModel? _selectedCity;
  CityModel? get selectedCity => _selectedCity;

  //Dropdown şehir değiştrme
  void setSelectedCity(CityModel? city) {
    _selectedCity = city;
    notifyListeners();
  }

  //Yetki Kontrolleri ve, Yönlendirmeler

  Future<void> requestLocationPermission() async {
    bool hasPermission = await _permissionService.requestLocationPermission();
    await _handlePermissionAndFetchWeather(hasPermission);
  }

  Future<bool> hasLocationPermission() async {
    return await _permissionService.hasLocationPermission();
  }

  Future<void> _checkPermission() async {
    if (await hasLocationPermission()) {
      fetchWeatherWithLocation();
      fetchCityFromLocation(true);
    } else {
      requestLocationPermission();
    }
  }

  //Konum tespiti konum yoksa bir sebebten ötürü otomatik Ankara
  Future<void> fetchWeatherWithLocation() async {
    Map<String, double> location =
        await _permissionService.getCurrentLocation();

    if (location.isNotEmpty) {
      await fetchWeatherByLocation(
        latitude: location['latitude']?.toString() ?? '39.92077',
        longitude: location['longitude']?.toString() ?? '32.85411',
      );
    } else {
      await fetchWeatherByLocation(latitude: '39.92077', longitude: '32.85411');
    }
  }

  //Konuma göre Hava Durumu Apisine İstek
  Future<void> fetchWeatherByLocation({
    required String latitude,
    required String longitude,
  }) async {
    try {
      final Map<String, dynamic> celsiusData = await apiService
          .getWeatherCelsius(latitude: latitude, longitude: longitude);
      _processWeatherCelsiusData(celsiusData);

      final Map<String, dynamic> fahrenheitData = await apiService
          .getWeatherFahrenheit(latitude: latitude, longitude: longitude);
      _processWeatherFahrenheitData(fahrenheitData);
    } catch (e) {
      _handleError(e);
    }
  }

  //Celcius un işlenmesi
  Future<void> _processWeatherCelsiusData(Map<String, dynamic> data) async {
    final List<String> hourlyTimeToday =
        _getHourlyTimeToday(List<String>.from(data['hourly']['time']));
    data['hourly']['time'] = hourlyTimeToday;

    _celsiusWeather = WeatherModel.fromJson(data);
    notifyListeners();
  }

  //Fahrenheit in işlenmesi
  Future<void> _processWeatherFahrenheitData(Map<String, dynamic> data) async {
    final List<String> hourlyTimeToday =
        _getHourlyTimeToday(List<String>.from(data['hourly']['time']));
    data['hourly']['time'] = hourlyTimeToday;

    _fahrenheitWeather = WeatherModel.fromJson(data);
    notifyListeners();
  }

  //İzin kontrolü ve apiden hava durumu .ekmek için yönlendirme
  Future<void> _handlePermissionAndFetchWeather(
    bool hasPermission,
  ) async {
    if (kDebugMode) {
      debugPrint("Konum izni durumu: $hasPermission");
    }
    if (hasPermission) {
      await fetchWeatherWithLocation();
      fetchCityFromLocation(true);
    } else {
      await fetchWeatherByLocation(latitude: '39.92077', longitude: '32.85411');
      fetchCityFromLocation(false);
    }
  }

  void _handleError(dynamic e) {
    if (kDebugMode) {
      debugPrint('Bir hata oluştu: $e');
    }
  }

  //Bulunduğumuz şehri bulmak vedropdown menüden seçtirmek için 
  Future<void> fetchCityFromLocation(bool isGranted) async {
    if (isGranted) {
      _city = await _permissionService.getCityFromLocation();
    } else {
      _city = 'Ankara';
    }
    if (_cityList != null) {
      for (CityModel city in _cityList!) {
        if (city.name == _city) {
          _selectedCity = city;
          break;
        }
      }
    }
    notifyListeners();
  }

  //Şehir Listesinin Apiden Çekimi 
  Future<void> _fetchCityListData() async {
    try {
      final Map<String, dynamic> cityData = await apiService.getCityListData();
      _cityList = cityData['data']
          .map<CityModel>((cityJson) => CityModel.fromJson(cityJson))
          .toList();
      notifyListeners();
    } catch (e) {
      _handleError(e);
    }
  }

  //Günlük Saat için Filtreleme
  List<String> _getHourlyTimeToday(List<dynamic> hourlyTimeList) {
    final List<String> hourlyTimeToday = [];
    final DateTime now = DateTime.now();

    for (int i = 0; i < hourlyTimeList.length; i++) {
      final DateTime hourlyTime = DateTime.parse(hourlyTimeList[i]);

      if (hourlyTime.day == now.day) {
        hourlyTimeToday.add(hourlyTimeList[i]);
      }
    }

    return hourlyTimeToday;
  }
}
