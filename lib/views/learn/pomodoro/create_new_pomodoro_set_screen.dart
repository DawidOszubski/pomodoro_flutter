import 'package:duration_picker/duration_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';

import '../../../constants/app_styles.dart';
import '../../../providers/theme_provider.dart';

class CreateNewPomodoroSetScreen extends ConsumerStatefulWidget {
  const CreateNewPomodoroSetScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPomodoroSetScreenState createState() =>
      _CreateNewPomodoroSetScreenState();
}

class _CreateNewPomodoroSetScreenState
    extends ConsumerState<CreateNewPomodoroSetScreen> {
  int? learnDuration;
  int? breakDuration;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "pomodoro.createSet".tr(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "pomodoro.createSetDescription".tr(),
                    style: AppStyles.descriptionStyle,
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Text("pomodoro.learnTime".tr()),
                        InkWell(
                          onTap: () async {
                            await showDurationPicker(
                              decoration: BoxDecoration(
                                color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              context: context,
                              initialTime: const Duration(minutes: 30),
                            ).then((value) => setState(() {
                                  learnDuration = value?.inMinutes;
                                }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(
                                  learnDuration == null
                                      ? "pomodoro.set".tr()
                                      : durationDisplay(learnDuration!),
                                  style: TextStyle(color: theme.mainColor),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.timer_outlined,
                                  color: theme.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        Text("pomodoro.breakTime".tr()),
                        InkWell(
                          onTap: () async {
                            await showDurationPicker(
                              decoration: BoxDecoration(
                                color: theme.backgroundColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              context: context,
                              initialTime: const Duration(minutes: 30),
                            ).then((value) => setState(() {
                                  if (value != null) {
                                    if (value.inMinutes > 0) {
                                      breakDuration = value.inMinutes;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "timeSnackBar".tr(),
                                        ),
                                      ));
                                    }
                                  }
                                }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Text(
                                  breakDuration == null
                                      ? "pomodoro.set".tr()
                                      : durationDisplay(breakDuration!),
                                  style: TextStyle(color: theme.mainColor),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.timer_outlined,
                                  color: theme.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: CustomButtonWidget(
                    buttonText: "pomodoro.createPomodoroSetBtn".tr(),
                    onTap: () {},
                    theme: theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String durationDisplay(int? duration) {
    if (duration != null) {
      if (duration == 1) {
        return "pomodoro.minute.one".tr(args: ["$duration"]);
      }
      if (duration.toString().endsWith("4") ||
          duration.toString().endsWith("2") ||
          duration.toString().endsWith("3")) {
        return "pomodoro.minute.minutes".tr(args: ["$duration"]);
      } else {
        return "pomodoro.minute.minute".tr(args: ["$duration"]);
      }
    }
    return "";
  }
}
