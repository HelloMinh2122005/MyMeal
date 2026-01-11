import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFB64B6), Color(0xFFFF637E)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient lightPinkBGCard = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFCE7F3), Color(0xFFFFE4E6)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient orangeBGCard = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFF8904), Color(0xFFFB64B6)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient pinkGradient1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFFE4E6), Color(0xFFFCE7F3)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient purplePinkGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient pinkRedSelection = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFB64B6), Color(0xFFFF637E)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient lightPinkBG = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFDF2F8), Color(0xFFFCE7F3), Color(0xFFFFE4E6)],
    stops: [0.0, 0.5, 1.0],
  );

  // Text colors
  static const Color textPink1 = Color(0xFFC6005C);
  static const Color textPink2 = Color(0xFFA3004C);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0A0A0A);
  static const Color textSecondary = Color(0xFF4A5565);
  static const Color mutedText = Color(0x800A0A0A);
  static const Color white80 = Color(0xCCFFFFFF);

  // UI colors
  static const Color iconPink = Color(0xFFC6005C);
  static const Color buttonLightPink = Color(0xFFFCE7F3);
  static const Color lightGrayBG = Color(0xFFF5F5F5);
  static const Color fccee8 = Color(0xFFFCCEE8);
}
