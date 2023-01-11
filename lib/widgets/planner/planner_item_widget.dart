import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/planner_models/task_model.dart';
import 'package:tuple/tuple.dart';

import '../../services/planner_service.dart';

class PlannerItemWidget extends ConsumerStatefulWidget {
  const PlannerItemWidget({
    Key? key,
    required this.theme,
    required this.task,
  }) : super(key: key);

  final AppThemeModel theme;
  final TaskModel task;

  @override
  _PlannerItemWidgetState createState() => _PlannerItemWidgetState();
}

class _PlannerItemWidgetState extends ConsumerState<PlannerItemWidget> {
  bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: 1.6,
                    child: Checkbox(
                      value: isSelected ?? widget.task.isDone == 1,
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.6),
                        width: 1,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isSelected = value!;
                          ref.read(plannerServiceProvider).checkDoneTask(
                                modelIsDone: Tuple2(
                                    widget.task, isSelected == true ? 1 : 0),
                              );
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith((states) {
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
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      "${widget.task.title}",
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          widget.task.date != null
              ? Positioned(
                  right: 8.0,
                  bottom: 8.0,
                  child: Text(
                    "${(widget.task.date)?.split('-')[2]}/${(widget.task.date)?.split('-')[1]}/${(widget.task.date)?.split('-')[0]}",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
