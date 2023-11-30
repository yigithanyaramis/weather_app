import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/bottom_navigation_constants.dart';
import 'core/constants/navigation_constants.dart';
import 'core/notifier/applicetion_provider.dart';
import 'core/themes/app_theme.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MultiProvider(
    providers: [
      ...ApplicationProvider.instance.dependItems,
      ...ApplicationProvider.instance.singleItems
    ],
    child: const WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.theme,
      home: const SplashScreen(),
      routes: {
        NavigationConstants.homeView: (context) => const BottomNavigation(
            selectedIndex: BottomNavigationConstants.homeView),
        NavigationConstants.settingsView: (context) => const BottomNavigation(
            selectedIndex: BottomNavigationConstants.settingsView),
      },
    );
  }
}
