import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class CustomButtonWidget extends StatefulWidget {
  const CustomButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.shadowColor,
    required this.onTap,
  }) : super(key: key);

  final String buttonText;
  final Color buttonColor;
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
          horizontal: 18.0,
        ),
        decoration: BoxDecoration(
            color: widget.buttonColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: widget.shadowColor,
                  offset: const Offset(4, 4),
                  blurRadius: 8,
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
