import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/views/time%20table/lesson_details_screen.dart';

class ClosestLessonListItemWidget extends StatelessWidget {
  const ClosestLessonListItemWidget({
    Key? key,
    this.color,
    required this.lessonDate,
    required this.lessonName,
    required this.lessonTopic,
  }) : super(key: key);

  final String lessonName;
  final String lessonTopic;
  final DateTime lessonDate;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    int min = 40;
    int max = 190;
    final r = min + math.Random().nextInt(max - min);
    final g = min + math.Random().nextInt(max - min);
    final b = min + math.Random().nextInt(max - min);
    final randomColor = Color.fromRGBO(r, g, b, 1);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: LessonDetailsScreen(
              lessonDate: lessonDate,
              lessonName: lessonName,
              lessonTopic: lessonTopic,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
            color: color ?? randomColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lessonName,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          lessonTopic,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(lessonDate),
              style: TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
