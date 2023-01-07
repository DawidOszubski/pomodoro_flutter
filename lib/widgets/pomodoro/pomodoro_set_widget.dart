import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/models/learn_models/pomodoro_set_model.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

import '../../views/learn/pomodoro/create_new_pomodoro_set_screen.dart';

class PomodoroSetWidget extends ConsumerStatefulWidget {
  const PomodoroSetWidget({
    Key? key,
    required this.pomodoroSet,
  }) : super(key: key);

  final PomodoroSetModel pomodoroSet;

  @override
  _PomodoroSetWidgetState createState() => _PomodoroSetWidgetState();
}

class _PomodoroSetWidgetState extends ConsumerState<PomodoroSetWidget> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: CreateNewPomodoroSetScreen(
              isEdit: true,
              pomodoroSet: widget.pomodoroSet,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    "pomodoro.learnTime".tr(),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                    child: Text("${widget.pomodoroSet.learnSectionTime} min")),
              ],
            ),
          ),
          Divider(
            color: theme.mainColor,
            height: 1,
            thickness: 1,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    "pomodoro.breakTime".tr(),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    "${widget.pomodoroSet.breakTime} min",
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: theme.mainColor,
            height: 1,
            thickness: 1,
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: Text(
                    "Ilość sesji pomodoro",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: CustomDropdownButton2(
                    buttonDecoration: BoxDecoration(
                        border: Border.all(
                          color: theme.mainColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    offset: Offset(-30, 0),
                    buttonWidth: 80,
                    icon: Icon(Icons.arrow_drop_down),
                    dropdownPadding: EdgeInsets.zero,
                    iconSize: 20,
                    iconEnabledColor: theme.mainColor,
                    hint: 'Select Item',
                    dropdownItems: [
                      "1",
                      "2",
                      "3",
                      "4",
                      "5",
                      "6",
                      "7",
                      "8",
                      "9",
                      "10"
                    ],
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
