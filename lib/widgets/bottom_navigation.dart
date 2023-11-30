import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/string_constants.dart';
import '../core/notifier/navigation_provider.dart';
import '../features/home/view/home_view.dart';
import '../features/settings/view/settings_view.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;

  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(selectedIndex: selectedIndex),
      child: Consumer<NavigationProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: _buildBody(provider.currentIndex),
            bottomNavigationBar: _buildBottomNavigationBar(context, provider),
          );
        },
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeView();
      case 1:
        return const SettingsView();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, NavigationProvider provider) {
    return BottomNavigationBar(
      currentIndex: provider.currentIndex,
      onTap: (index) => provider.currentIndex = index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: StringConstants.homePage,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: StringConstants.settings,
        ),
      ],
    );
  }
}
