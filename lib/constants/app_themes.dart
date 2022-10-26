import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static final mainTheme = AppThemeModel(
    mainColor: AppColors.mainColor,
    backgroundColor: AppColors.backgroundColor,
    mainColorDarker: AppColors.mainColorDarker,
    mainColorLighter: AppColors.mainColorLighter,
  );

  static final aluniaTheme = AppThemeModel(
    mainColor: AppColors.mainColorAlunia,
    backgroundColor: AppColors.backgroundColorAlunia,
    mainColorDarker: AppColors.mainColorDarkerAlunia,
    mainColorLighter: AppColors.mainColorLighterAlunia,
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
