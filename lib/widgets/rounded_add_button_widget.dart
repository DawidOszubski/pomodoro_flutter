import 'package:flutter/material.dart';

import '../constants/app_themes.dart';

class RoundedAddButtonWidget extends StatelessWidget {
  const RoundedAddButtonWidget({
    Key? key,
    required this.theme,
    required this.onTap,
  }) : super(key: key);

  final AppThemeModel theme;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: theme.gradientButton,
          boxShadow: [
            BoxShadow(
                color: theme.mainColorDarker,
                offset: const Offset(1, 1),
                blurRadius: 2,
                spreadRadius: 2),
          ],
        ),
        child: const FittedBox(
          fit: BoxFit.contain,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
