import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

import '../../main.dart';
import '../../providers/task_provider.dart';
import '../../widgets/planner/planner_item_widget.dart';
import 'add_task_screen.dart';
import 'delete_task_screen.dart';

class ToDoListScreen extends ConsumerStatefulWidget {
  const ToDoListScreen({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends ConsumerState<ToDoListScreen>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    ref.refresh(
      getTasksProvider(
        selectDate(selectedDate: selectedValue!),
      ),
    );
    super.didPopNext();
  }

  final List<String> items = [
    'planner.today'.tr(),
    'planner.thisWeek'.tr(),
    "planner.all".tr()
  ];
  String? selectedValue = 'planner.today'.tr();

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(
      getTasksProvider(
        selectDate(selectedDate: selectedValue!),
      ),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 24,
                  iconEnabledColor: widget.theme.mainColor,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 12, right: 12),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 160,
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  dropdownElevation: 2,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 3,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(0, 0),
                ),
              ),
              /*Expanded(
                child: Center(
                  child: Text(
                    "planner.selectAll".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: widget.theme.mainColor),
                  ),
                ),
              ),*/
            ],
          ),
        ),
        Expanded(
          child: tasks.when(
            data: (tasks) {
              if (tasks != null) {
                return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 12.0,
                            ),
                            child: InkWell(
                              onLongPress: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: DeleteTaskScreen(
                                        theme: widget.theme,
                                        task: tasks[index]),
                                  ),
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(
                                      milliseconds: 350,
                                    ),
                                    child: AddTaskScreen(
                                        theme: widget.theme,
                                        task: tasks[index]),
                                  ),
                                );
                              },
                              child: PlannerItemWidget(
                                  theme: widget.theme, task: tasks[index]),
                            ),
                          ),
                          index == tasks.length - 1
                              ? SizedBox(
                                  height: 90 +
                                      MediaQuery.of(context).padding.bottom,
                                )
                              : Container(),
                        ],
                      );
                    });
              } else {
                return Container();
              }
            },
            error: (err, s) => Center(
              child: Container(
                child: Text("Error"),
              ),
            ),
            loading: () {
              return Container(); /* ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.2),
                    highlightColor: Colors.white.withOpacity(0.4),
                    period: Duration(milliseconds: 1200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      child: PlannerItemWidget(
                          theme: widget.theme, task: TaskModel()),
                    ),
                  );
                },
              );*/
            },
          ),
        ),
      ],
    );
  }

  String? selectDate({required String selectedDate}) {
    if (selectedDate == 'planner.today'.tr()) {
      return DateFormat('yyyy-MM-DD').format(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      );
    }
    if (selectedDate == 'planner.thisWeek'.tr()) {
      return DateFormat('yyyy-MM-DD').format(
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 7),
      );
    }
    if (selectedDate == "planner.all".tr()) {
      return null;
    }
  }
}
