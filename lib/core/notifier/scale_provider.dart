import 'package:flutter/material.dart';

import '../constants/scale_constants.dart';
import '../services/preferences_service.dart';

//Scale için Provider
class ScaleProvider with ChangeNotifier {
  ScaleProvider() {
    loadUnitPreference();
  }

  String _currentScale = ScaleConstants.celsius;
  final PreferencesService _preferencesService = PreferencesService();

  String get currentScale => _currentScale;

  Future<void> setUnitPreference(String scale) async {
    _currentScale = scale;
    await _preferencesService.setUnitPreference(_currentScale);
    notifyListeners();
  }

  Future<void> loadUnitPreference() async {
    _currentScale = await _preferencesService.getUnitPreference();
    notifyListeners();
  }
}
