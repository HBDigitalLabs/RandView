import 'package:flutter/material.dart';

class LicenseData {
  final String license;
  final String notice;
  LicenseData(this.license, this.notice);
}

class AppSizes {
  static const double lineThickness = 2;
  static const double appBarFontSize = 18;
  static const double spacingSmall = 5;
  static const double spacingBig = 30;
  static const double padding = 10;
  static const double margin = 8;
  static const double radius = 10;
}

class AppColors {

  // Backgrounds
  static const background = Color(0xFF080A0D);
  static const appBar = Color(0xFF11161C);

  // Surfaces
  static const surface = Color(0xFF1B2128);
  static const surfaceVariant = Color(0xFF171C22);

  // Interaction
  static const hover = Color(0xFF2A3138);
  static const pressed = Color(0xFF404A55);

  // Lines / borders
  static const divider = Color(0xFF151A20);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB0B8C0);

  // Accent
  static const accent = Color(0xFF00E3CD);
  // static const accentSoft = Color(0x3300E3CD);

}

/*
class AppColors {

  // Backgrounds
  static const background = Color(0xFF0B0B0B);
  static const appBar = Color(0xFF131313);

  // Surfaces
  static const surface = Color(0xFF1F1F1F);
  static const surfaceVariant = Color.fromARGB(255, 24, 24, 24);

  // Interaction
  static const hover = Color(0xFF333333);
  static const pressed = Color.fromARGB(255, 85, 85, 85);

  // Lines / borders
  static const divider = Color(0xFF141414);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB3B3B3);

  // Accent
  static const accent = Color(0xFF00E3CD);
  static const accentSoft = Color(0x3300E3CD);

}*/
