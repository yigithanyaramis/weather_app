import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/notifier/scale_provider.dart';

class SettingsViewModel extends ChangeNotifier {
  //Ölçünün Lokalde değiştirilmesi için istek
  Future<void> setUnitPreference(BuildContext context, String value) async {
    await Provider.of<ScaleProvider>(context, listen: false)
        .setUnitPreference(value);
    notifyListeners();
  }
}
