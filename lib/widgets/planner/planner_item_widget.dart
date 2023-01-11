import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

class PlannerItemWidget extends StatefulWidget {
  const PlannerItemWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;

  @override
  State<PlannerItemWidget> createState() => _PlannerItemWidgetState();
}

class _PlannerItemWidgetState extends State<PlannerItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(2, 2),
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  value: isSelected,
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.6),
                    width: 1,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isSelected = value!;
                    });
                  },
                  fillColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.selected)) {
                      return Colors.green;
                    }
                    return Colors.white;
                  }),
                ),
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text("Zadanie"),
          ],
        ),
      ),
    );
  }
}
