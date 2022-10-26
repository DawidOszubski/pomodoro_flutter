import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

import 'closest_lessons_screen.dart';
import 'lessons_schedule_screen.dart';

class TimeTableScreen extends ConsumerStatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends ConsumerState<TimeTableScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController1;

  @override
  void initState() {
    tabController1 = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(appThemeProvider);
    // final primaryColor = themeData["primaryColor"];
    //final backgroundColor = themeData["backgroundColor"];
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: themeData.mainColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Plan zajęć"),
          centerTitle: true,
          backgroundColor: themeData.mainColor,
          bottom: TabBar(
            controller: tabController1,
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.zero,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Najbliższe zajęcia"),
              Tab(text: "Plan zajęć"),
            ],
          ),
        ),
        body: Container(
          color: themeData.backgroundColor,
          child: TabBarView(
            controller: tabController1,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ClosestLessonsScreen(),
              LessonsScheduleScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
