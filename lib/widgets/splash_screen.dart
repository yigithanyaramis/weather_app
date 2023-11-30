import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/constants/duration_constants.dart';
import '../core/constants/image_constants.dart';
import '../core/constants/navigation_constants.dart';
import '../core/constants/padding_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      DurationConstants.instance.highDuration,
      () {
        Navigator.pushReplacementNamed(context, NavigationConstants.homeView);
      },
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: PaddingConstants.instance.basePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(ImageConstants.instance.logo),
              const CircularProgressIndicator(),
              const Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
