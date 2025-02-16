import 'package:bachmeal/screens/auth/register_screen.dart';
import 'package:bachmeal/screens/flash_screen.dart';
import 'package:bachmeal/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String flash = "/";
  static const String onboarding = "/onboarding";
  static const String register = "/register";

  static Map<String, WidgetBuilder> routes = {
    flash: (context) => SplashScreen(),
    onboarding: (context) => OnboardingScreen(),
    register: (context) => SignUpScreen(),
  };
}
