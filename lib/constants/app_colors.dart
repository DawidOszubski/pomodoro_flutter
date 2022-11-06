import 'package:flutter/material.dart';

class AppColors {
  static const mainColorBlue = Color.fromRGBO(119, 205, 255, 1.0);
  static const mainColorDarkerBlue = Color.fromRGBO(8, 91, 215, 1.0);
  static const mainColorLighterBlue = Color.fromRGBO(201, 231, 255, 1.0);
  static const backgroundColorBlue = Colors.white;
  static const blueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(119, 205, 255, 1),
      Color.fromRGBO(82, 192, 255, 1),
      Color.fromRGBO(30, 178, 255, 1),
      Color.fromRGBO(0, 163, 255, 1),
      Color.fromRGBO(0, 147, 255, 1),
      Color.fromRGBO(0, 130, 255, 1),
      Color.fromRGBO(0, 112, 255, 1),
    ],
    tileMode: TileMode.mirror,
  );
  static const blueGradientButtons = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(82, 192, 255, 1),
      Color.fromRGBO(30, 178, 255, 1),
      Color.fromRGBO(0, 163, 255, 1),
      Color.fromRGBO(0, 147, 255, 1),
      Color.fromRGBO(0, 130, 255, 1),
    ],
    tileMode: TileMode.mirror,
  );

  /////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////
  static const mainColorBrown = Color.fromRGBO(238, 189, 143, 1.0);
  static const mainColorDarkerBrown = Color.fromRGBO(115, 92, 65, 1.0);
  static const mainColorLighterBrown = Color.fromRGBO(255, 210, 183, 1.0);
  static const darkBrown = Color.fromRGBO(105, 66, 22, 1.0);
  static const backgroundColor = Colors.white;
  static const brownGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(238, 189, 143, 1),
      Color.fromRGBO(238, 189, 143, 1),
      Color.fromRGBO(218, 170, 124, 1),
      Color.fromRGBO(199, 152, 106, 1),
    ],
    tileMode: TileMode.mirror,
  );
  static const brownGradientButtons = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(238, 189, 143, 1),
      Color.fromRGBO(238, 189, 143, 1),
      Color.fromRGBO(218, 170, 124, 1),
      Color.fromRGBO(199, 152, 106, 1),
    ],
    tileMode: TileMode.mirror,
  );
  /////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////
  static const mainColorRed = Color.fromRGBO(170, 60, 57, 1.0);
  static const mainColorLighterRed = Color.fromRGBO(208, 94, 90, 1.0);
  static const mainColorDarkerRed = Color.fromRGBO(93, 2, 0, 1.0);
  static const backgroundColorRed = Colors.white;
  static const secondaryColorRed = Color.fromRGBO(35, 100, 103, 1);
  static const secondaryColorDarkerRed = Color.fromRGBO(0, 54, 56, 1);
  static const secondaryColorLighterRed = Color.fromRGBO(112, 147, 149, 1);
  static const redGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(170, 60, 57, 1),
      Color.fromRGBO(159, 52, 49, 1),
      Color.fromRGBO(147, 45, 41, 1),
      Color.fromRGBO(136, 37, 34, 1),
      Color.fromRGBO(125, 29, 27, 1),
      Color.fromRGBO(114, 21, 19, 1),
    ],
    tileMode: TileMode.mirror,
  );
  static const redGradientButtons = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0, 1),
    colors: <Color>[
      Color.fromRGBO(170, 60, 57, 1),
      Color.fromRGBO(159, 52, 49, 1),
      Color.fromRGBO(147, 45, 41, 1),
      Color.fromRGBO(136, 37, 34, 1),
      Color.fromRGBO(125, 29, 27, 1),
    ],
    tileMode: TileMode.mirror,
  );
}
