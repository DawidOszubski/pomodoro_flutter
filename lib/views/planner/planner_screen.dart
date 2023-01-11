import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/views/planner/add_task_screen.dart';
import 'package:pomodoro_flutter/views/planner/todo_list_screen.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';

class PlannerScreen extends ConsumerStatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends ConsumerState<PlannerScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Tab> tabs = [
    Tab(
      height: 50,
      child: Text(
        "planner.todoList".tr(),
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    ),
    Tab(
      height: 50,
      child: Text(
        "planner.timeManagementMatrix".tr(),
        style: const TextStyle(
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    )
  ];

  @override
  void initState() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      isTabBar: true,
      mainColor: theme.mainColor,
      screenTitle: "planner.title".tr(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(2, 2),
                        blurRadius: 5.0,
                        spreadRadius: 1.0),
                  ],
                ),
                child: TabBar(
                  controller: tabController,
                  tabs: tabs,
                  indicatorPadding: const EdgeInsets.only(
                    left: 48.0,
                    right: 48.0,
                    bottom: 4.0,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ToDoListScreen(theme: theme),
                    Icon(Icons.directions_transit),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 24.0 + MediaQuery.of(context).padding.bottom,
            right: 24.0,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RoundedAddButtonWidget(
                theme: theme,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: AddTaskScreen(theme: theme),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
