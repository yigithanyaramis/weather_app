//Hava Durumu Modeli
class WeatherModel {
  double latitude;
  double longitude;
  double generationtimeMs;
  int utcOffsetSeconds;
  String timezone;
  String timezoneAbbreviation;
  double elevation;

  Map<String, String> currentUnits;
  String currentTime;
  int currentInterval;
  double currentTemperature2m;
  double currentRain;
  int currentWeatherCode;
  double currentWindSpeed;

  Map<String, String> hourlyUnits;
  List<String> hourlyTime;
  List<double> hourlyTemperature;
  List<int> hourlyWeatherCode;

  Map<String, String> dailyUnits;
  List<String> dailyTime;
  List<double> dailyTemperatureMax;
  List<double> dailyTemperatureMin;
  List<int> dailyWeatherCode;
  List<double> dailyUVIndex;

  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.currentTime,
    required this.currentInterval,
    required this.currentTemperature2m,
    required this.currentRain,
    required this.currentWeatherCode,
    required this.currentWindSpeed,
    required this.hourlyUnits,
    required this.hourlyTime,
    required this.hourlyTemperature,
    required this.hourlyWeatherCode,
    required this.dailyUnits,
    required this.dailyTime,
    required this.dailyTemperatureMax,
    required this.dailyTemperatureMin,
    required this.dailyWeatherCode,
    required this.dailyUVIndex,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude']?.toDouble() ?? 0.0,
        longitude = json['longitude']?.toDouble() ?? 0.0,
        generationtimeMs = json['generationtime_ms']?.toDouble() ?? 0.0,
        utcOffsetSeconds = json['utc_offset_seconds'] ?? 0,
        timezone = json['timezone'] ?? "",
        timezoneAbbreviation = json['timezone_abbreviation'] ?? "",
        elevation = json['elevation']?.toDouble() ?? 0.0,
        currentUnits = Map<String, String>.from(json['current_units'] ?? {}),
        currentTime = json['current']['time'] ?? "",
        currentInterval = json['current']['interval'] ?? 0,
        currentTemperature2m =
            json['current']['temperature_2m']?.toDouble() ?? 0.0,
        currentRain = json['current']['rain']?.toDouble() ?? 0.0,
        currentWeatherCode = json['current']['weather_code'] ?? 0,
        currentWindSpeed = json['current']['wind_speed_10m'] ?? 0.0,
        hourlyUnits = Map<String, String>.from(json['hourly_units'] ?? {}),
        hourlyTime = List<String>.from(json['hourly']['time'] ?? []),
        hourlyTemperature =
            List<double>.from(json['hourly']['temperature_2m'] ?? []),
        hourlyWeatherCode =
            List<int>.from(json['hourly']['weather_code'] ?? []),
        dailyUnits = Map<String, String>.from(json['daily_units'] ?? {}),
        dailyTime = List<String>.from(json['daily']['time'] ?? []),
        dailyTemperatureMax =
            List<double>.from(json['daily']['temperature_2m_max'] ?? []),
        dailyWeatherCode = List<int>.from(json['daily']['weather_code'] ?? []),
        dailyUVIndex = List<double>.from(json['daily']['uv_index_max'] ?? []),
        dailyTemperatureMin =
            List<double>.from(json['daily']['temperature_2m_min'] ?? []);
}
