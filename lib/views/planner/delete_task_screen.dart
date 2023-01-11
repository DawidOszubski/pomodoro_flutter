import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/planner_models/task_model.dart';
import 'package:pomodoro_flutter/services/planner_service.dart';

import '../../constants/app_styles.dart';
import '../../widgets/pop_up_widget.dart';

class DeleteTaskScreen extends ConsumerStatefulWidget {
  const DeleteTaskScreen({
    Key? key,
    required this.task,
    required this.theme,
    this.isDoublePop,
  }) : super(key: key);

  final AppThemeModel theme;
  final TaskModel task;
  final bool? isDoublePop;

  @override
  _DeleteTaskScreenState createState() => _DeleteTaskScreenState();
}

class _DeleteTaskScreenState extends ConsumerState<DeleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return PopUpWidget(
        title: "planner.deleteTitle1".tr(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              Text(
                "planner.deleteDescription1".tr(),
                textAlign: TextAlign.center,
                style: AppStyles.textStyle,
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(plannerServiceProvider)
                          .deleteTask(widget.task)
                          .then((value) {
                        Navigator.of(context).pop();
                        if (widget.isDoublePop != null) {
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "yes".tr(),
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: widget.theme.mainColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "no".tr(),
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: widget.theme.mainColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
        mainColor: widget.theme.mainColor);
  }
}
