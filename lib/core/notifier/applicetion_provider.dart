import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/home/view_model/home_view_model.dart';
import '../../features/settings/view_model/settings_view_model.dart';
import '../services/api_service.dart';
import '../services/permission_service.dart';
import '../services/preferences_service.dart';
import 'navigation_provider.dart';
import 'scale_provider.dart';

class ApplicationProvider {
  ApplicationProvider._init();

  static final ApplicationProvider _instance = ApplicationProvider._init();
  static ApplicationProvider get instance => _instance;

  // Tekil Nesneler
  List<SingleChildWidget> singleItems = [
    ChangeNotifierProvider(create: (_) => ApiService()),
    ChangeNotifierProvider(create: (_) => PreferencesService()),
    ChangeNotifierProvider(create: (_) => PermissionService()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => ScaleProvider()),
  ];

  //Durum Yönetimi 
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => SettingsViewModel()),
  ];

  //Arayüz (Tema Değişimi Gibi)
  //List<SingleChildWidget> uiChangesItems = [];
}
