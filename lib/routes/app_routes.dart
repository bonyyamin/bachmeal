import 'package:bachmeal/screens/auth/register_screen.dart';
import 'package:bachmeal/screens/on_boarding/flash_screen.dart';
import 'package:bachmeal/screens/on_boarding/onboarding_screen.dart';
import 'package:bachmeal/screens/on_boarding/taking_information_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String flash = "/";
  static const String onboarding = "/onboarding";
  static const String takinginfo = "/takinginfo";
  static const String register = "/register";

  static Map<String, WidgetBuilder> routes = {
    flash: (context) => SplashScreen(),
    onboarding: (context) => OnboardingScreen(),
    takinginfo: (context) => TakingInformationScreen(),
    register: (context) => SignUpScreen(),
  };
}
