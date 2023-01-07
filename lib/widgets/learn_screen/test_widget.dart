import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.2,
        minHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                2.0,
                2.0,
              ),
              spreadRadius: 0,
              blurRadius: 4,
            ),
            BoxShadow(
              color: theme.mainColorDarker.withOpacity(0.6),
              offset: const Offset(
                3.0,
                3.0,
              ),
              spreadRadius: 0,
              blurRadius: 8,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                "Sprawdzian z pierwsiastków",
                // textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Align(alignment: Alignment.bottomRight, child: Text("24.01.2023")),
          ],
        ),
      ),
    );
  }
}
