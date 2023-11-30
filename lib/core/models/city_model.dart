//Şehir Modeli
class CityModel {
  String name;
  Map<String, double>? coordinates;

  CityModel({
    required this.name,
    this.coordinates,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      coordinates: {
        'latitude': (json['coordinates']['latitude'] ?? 0).toDouble(),
        'longitude': (json['coordinates']['longitude'] ?? 0).toDouble(),
      },
    );
  }
}
