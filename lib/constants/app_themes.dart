import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final mainTheme = AppThemeModel(
    mainColor: AppColors.mainColorBrown,
    backgroundColor: AppColors.backgroundColor,
    mainColorDarker: AppColors.mainColorDarkerBrown,
    mainColorLighter: AppColors.mainColorLighterBrown,
  );

  static final aluniaTheme = AppThemeModel(
    mainColor: AppColors.mainColorBlue,
    backgroundColor: AppColors.backgroundColorBlue,
    mainColorDarker: AppColors.mainColorDarkerBlue,
    mainColorLighter: AppColors.mainColorLighterBlue,
  );

  static final pomodoroTheme = AppThemeModel(
    mainColor: AppColors.mainColorRed,
    backgroundColor: AppColors.backgroundColorRed,
    mainColorDarker: AppColors.mainColorDarkerRed,
    mainColorLighter: AppColors.mainColorLighterRed,
  );
}

class AppThemeModel {
  final Color mainColor;
  final Color backgroundColor;
  final Color mainColorDarker;
  final Color mainColorLighter;

  AppThemeModel({
    required this.mainColor,
    required this.backgroundColor,
    required this.mainColorDarker,
    required this.mainColorLighter,
  });
}
