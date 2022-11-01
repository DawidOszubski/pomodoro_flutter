import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_assets.dart';
import 'package:pomodoro_flutter/constants/app_colors.dart';
import 'package:pomodoro_flutter/widgets/time%20table%20widgets/closest_lesson_list_item_widget.dart';

class ClosestLessonsScreen extends StatefulWidget {
  const ClosestLessonsScreen({Key? key}) : super(key: key);

  @override
  State<ClosestLessonsScreen> createState() => _ClosestLessonsScreenState();
}

class _ClosestLessonsScreenState extends State<ClosestLessonsScreen> {
  late List<ClosestLessonListItemWidget> lessonList = [];
  @override
  void initState() {
    lessonList = [
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 1",
        lessonName: "Nazwa Przedmiotu 1",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 2",
        lessonName: "Nazwa Przedmiotu2",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 3",
        lessonName: "Nazwa Przedmiotu 3",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 4",
        lessonName: "Nazwa Przedmiotu 4",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 5",
        lessonName: "Nazwa Przedmiotu 5",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 6",
        lessonName: "Nazwa Przedmiotu 6",
        lessonDate: DateTime.now(),
      ),
      ClosestLessonListItemWidget(
        lessonTopic: "Temat 7",
        lessonName: "Nazwa Przedmiotu 7",
        lessonDate: DateTime.now(),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        //height: 200,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: AppColors.mainColorBrown,
            /*  gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(255, 238, 224, 1.0),
                AppColors.mainColor,
              ],
            ),*/
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 15.0,
                offset: Offset(4, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 15.0,
                offset: Offset(-4, -4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.testIcon,
                width: MediaQuery.of(context).size.width / 3,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Text("Najblizszy test"),
            ],
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          //physics: NeverScrollableScrollPhysics(),
          itemCount: lessonList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return lessonList[index];
          },
        ),
      ),
    ]);
  }
}
