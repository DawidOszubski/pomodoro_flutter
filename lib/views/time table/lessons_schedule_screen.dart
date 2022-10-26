import 'package:flutter/material.dart';

class LessonsScheduleScreen extends StatefulWidget {
  const LessonsScheduleScreen({Key? key}) : super(key: key);

  @override
  State<LessonsScheduleScreen> createState() => _LessonsScheduleScreenState();
}

class _LessonsScheduleScreenState extends State<LessonsScheduleScreen>
    with SingleTickerProviderStateMixin {
  //late TabController tabController;
  //final datePickController = DatePickerController();
  @override
  void initState() {
    /* tabController = TabController(length: 5, vsync: this, initialIndex: 0)
      ..addListener(() {
        if (tabController.index == 6) {
          setState(() {
            tabController.index = 0;
          });
        }
      });
*/
    super.initState();
  }

  var idx = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.green,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.orange,
        ),
      ],
    ); /*Container(
      child: SfCalendar(
        view: CalendarView.workWeek,
        allowDragAndDrop: true,
        monthViewSettings: MonthViewSettings(
            navigationDirection: MonthNavigationDirection.horizontal),
      ),
    ); */
    /*   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
              child: Text(DateTime.now().month.toString()),
            ),
            /* DatePicker(
              DateTime.now(),
              selectionColor: AppColors.mainColor,
              initialSelectedDate: DateTime.now(),
              controller: datePickController,
              daysCount: 7,
              locale: "pl",
            )*/
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_outlined),
                  Expanded(
                    child: TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      padding: EdgeInsets.zero,
                      indicatorColor: Colors.red,
                      labelStyle: TextStyle(color: Colors.black),
                      labelColor: Colors.black,
                      tabs: [
                        Column(
                          children: [
                            Text(DateTime.utc(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                                .day
                                .toString()),
                            Text("Pn"),
                          ],
                        ),
                        Column(
                          children: [
                            Text(DateTime.utc(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    (DateTime.now().day + 1))
                                .day
                                .toString()),
                            Text("Wt"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("03"),
                            Text("Sr"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("04"),
                            Text("Cz"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("05"),
                            Text("Pt"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height - 200,
            child: TabBarView(controller: tabController, children: [
              Container(
                height: 20,
                width: 20,
                color: Colors.red,
              ),
              Container(
                height: 300,
                width: 20,
                color: Colors.blue,
              ),
              Container(
                height: 300,
                width: 20,
                color: Colors.yellow,
              ),
              Container(
                height: 300,
                width: 20,
                color: Colors.green,
              ),
              Container(
                height: 300,
                width: 20,
                color: Colors.purple,
              ),
            ]),
          ),
        ),
      ],
    );*/
  }
}
