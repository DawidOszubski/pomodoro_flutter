import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_colors.dart';

class AppStyles {
  static const detailsTitleStyle = TextStyle(
      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 24.0);

  static const detailsBodyStyle =
      TextStyle(color: Colors.black, fontSize: 18.0);

  static const buttonTextStyle = TextStyle(
    color: AppColors.backgroundColor,
    fontSize: 18.0,
  );

  static const buttonTextDarkerStyle = TextStyle(
    color: AppColors.darkBrown,
    fontSize: 18.0,
  );

  static const yesNoButtonOptionsStyle = TextStyle(
    fontSize: 18.0,
    letterSpacing: 1.12,
    fontWeight: FontWeight.bold,
  );

  static const popUpTitleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.12,
  );

  static const textStyle = TextStyle(
    fontSize: 16.0,
  );

  static const secondaryButtonStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );
  static const descriptionStyle =
      TextStyle(fontSize: 18, letterSpacing: 1.0, color: Colors.black);
}
