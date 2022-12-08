import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/views/flash%20cards/add_new.dart';

class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;

  @override
  Widget build(BuildContext context) {
    var minHeight = 100.0;
    var maxHeight = 200.0;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(
              milliseconds: 350,
            ),
            child: AddNew(),
          ),
        );
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: minHeight,
          maxHeight: maxHeight,
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Container(
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
          child: Text("text"),
        ),
      ),
    );
  }
}
