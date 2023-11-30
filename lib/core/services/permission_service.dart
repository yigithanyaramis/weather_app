import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

//Yetki ile yapılan işlemler servisi
class PermissionService extends ChangeNotifier {
  Future<bool> requestLocationPermission() async {
    try {
      PermissionStatus status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else if (status == PermissionStatus.permanentlyDenied) {
        //openAppSettings();
        return false;
      } else {
        _handlePermissionDenied(status);
        return false;
      }
    } catch (e) {
      _handlePermissionError(e);
      return false;
    }
  }

  //Yetki varmı yokmu?
  Future<bool> hasLocationPermission() async {
    return await Permission.location.isGranted;
  }

  //Güncel konum
  Future<Map<String, double>> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      _handleLocationError(e);
      return {};
    }
  }

  //Bulunduğumuz Şehir
  Future<String> getCityFromLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return placemarks.first.administrativeArea ?? 'Ankara';
    } catch (e) {
      _handleLocationError(e);
      return 'Ankara';
    }
  }

  //Debug Mesajları

  void _handlePermissionDenied(PermissionStatus status) {
    if (kDebugMode) {
      debugPrint("İzin reddedildi veya hata oluştu: $status");
    }
  }

  void _handlePermissionError(dynamic e) {
    if (kDebugMode) {
      debugPrint("İzin talebi sırasında bir hata oluştu: $e");
    }
  }

  void _handleLocationError(dynamic e) {
    if (kDebugMode) {
      debugPrint('Konum bilgileri alınamadı: $e');
    }
  }
}
