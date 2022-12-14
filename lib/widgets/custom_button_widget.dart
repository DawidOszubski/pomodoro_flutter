import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonGradientColor,
    required this.shadowColor,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final Gradient buttonGradientColor;
  final Color shadowColor;
  final void Function()? onTap;

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
            gradient: widget.buttonGradientColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: widget.shadowColor,
                  offset: const Offset(2, 2),
                  blurRadius: 6,
                  spreadRadius: 1),
            ]),
        child: Text(
          widget.buttonText,
          style: textStyle,
        ),
      ),
    );
  }
}
