import 'package:flutter/material.dart';
import '../../values/asset_value.dart';
import '../../values/color_value.dart';
import '../../values/route_value.dart';
import '../../values/text_style_value.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  void nextScreen() {
    Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RouteValue.routeNameToLogin,
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetValue.splash_image,
              color: ColorValue.primaryColor.withOpacity(0.9),
              scale: 1.2,
            ),
            const SizedBox(height: 10),
            Text(
              'Shopping',
              style: TextStyleValue.h1.copyWith(
                color: ColorValue.primaryColor.withOpacity(0.9),
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
