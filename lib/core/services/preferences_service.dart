import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/scale_constants.dart';
import '../enums/shared_preferences_enum.dart';


//Locale 'e kaydetmemizi sağlayın servisimiz.
class PreferencesService extends ChangeNotifier {
  Future<String> getUnitPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferencesKeys.SCALE.toString()) ??
        ScaleConstants.celsius;
  }

  Future<void> setUnitPreference(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferencesKeys.SCALE.toString(), unit);
  }
}
