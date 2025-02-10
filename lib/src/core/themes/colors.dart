// coverage:ignore-file
import 'package:flutter/material.dart';

abstract final class AppColors {
  static const black1 = Color(0xFF101010);
  static const black2 = Color(0xFF202020);
  static const white1 = Color(0xFFFFF7FA);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFFD3D3D3);
  static const grey3 = Color(0xFFA4A4A4);
  static const whiteTransparent = Color(0x4DFFFFFF);
  static const blackTransparent = Color(0x33000000);
  static const transparent = Color(0x00000000);
  static const red1 = Color(0xFFE74C3C);
  static const gold = Color(0xFFFFA500);
  static const turquoise = Color(0xFF22D3BB);

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.black1,
    onPrimary: AppColors.white1,
    secondary: AppColors.black1,
    onSecondary: AppColors.white1,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.white,
    onError: Colors.red,
    background: grey1,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white1,
    onPrimary: AppColors.black1,
    secondary: AppColors.white1,
    onSecondary: AppColors.black1,
    surface: AppColors.black1,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.red1,
    background: grey1,
  );
}
