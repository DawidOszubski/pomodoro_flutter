import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final brownTheme = AppThemeModel(
      mainColor: AppColors.mainColorBrown,
      backgroundColor: AppColors.backgroundColor,
      mainColorDarker: AppColors.mainColorDarkerBrown,
      mainColorLighter: AppColors.mainColorLighterBrown,
      gradient: AppColors.brownGradient,
      gradientButton: AppColors.brownGradientButtons);

  static final blueTheme = AppThemeModel(
      mainColor: AppColors.mainColorBlue,
      backgroundColor: AppColors.backgroundColorBlue,
      mainColorDarker: AppColors.mainColorDarkerBlue,
      mainColorLighter: AppColors.mainColorLighterBlue,
      gradient: AppColors.blueGradient,
      gradientButton: AppColors.blueGradientButtons);

  static final redTheme = AppThemeModel(
      mainColor: AppColors.mainColorRed,
      backgroundColor: AppColors.backgroundColorRed,
      mainColorDarker: AppColors.mainColorDarkerRed,
      mainColorLighter: AppColors.mainColorLighterRed,
      gradient: AppColors.redGradient,
      gradientButton: AppColors.redGradientButtons);
}

class AppThemeModel {
  final Color mainColor;
  final Color backgroundColor;
  final Color mainColorDarker;
  final Color mainColorLighter;
  final LinearGradient gradient;
  final LinearGradient gradientButton;

  AppThemeModel({
    required this.mainColor,
    required this.backgroundColor,
    required this.mainColorDarker,
    required this.mainColorLighter,
    required this.gradient,
    required this.gradientButton,
  });
}
