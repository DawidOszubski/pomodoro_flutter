import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

import '../constants/app_styles.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({
    Key? key,
    required this.buttonText,
    required this.onTap,
    required this.theme,
  }) : super(key: key);

  final String buttonText;

  final void Function()? onTap;
  final AppThemeModel theme;

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  var textStyle = AppStyles.buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onTapUp: (_) {
        setState(() {
          textStyle = AppStyles.buttonTextStyle;
        });
      },
      onTapDown: (_) {
        setState(() {
          textStyle = AppStyles.buttonTextDarkerStyle;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 30.0,
        ),
        decoration: BoxDecoration(
          //color: widget.buttonColor,
          gradient: widget.theme.gradientButton,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: widget.theme.mainColorDarker,
                offset: const Offset(2, 6),
                blurRadius: 2,
                spreadRadius: 0),
          ],
        ),
        child: Text(
          widget.buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
