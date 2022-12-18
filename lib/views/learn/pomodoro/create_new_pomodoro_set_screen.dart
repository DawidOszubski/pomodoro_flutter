import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../../providers/theme_provider.dart';

class CreateNewPomodoroSetScreen extends ConsumerStatefulWidget {
  const CreateNewPomodoroSetScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPomodoroSetScreenState createState() =>
      _CreateNewPomodoroSetScreenState();
}

class _CreateNewPomodoroSetScreenState
    extends ConsumerState<CreateNewPomodoroSetScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "Utwórz set Pomodoro",
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Text(
                  "Stwórz własny set Pomodoro dopasowany do Ciebie!\n\nMożesz wybrać ile czas potrafisz zachować największe skupienie oraz ile potrzebuejsz czasu na przerwę pomiędzy każdym setem."),
              Row(
                children: [
                  Text("Czas pojedyńczego setu Pomodoro"),
                  InkWell(
                    onTap: () async {
                      /* showTimePicker(
                          context: context, initialTime: TimeOfDay.now());*/
                      var resultingDuration = await showDurationPicker(
                        decoration: BoxDecoration(
                          color: theme.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        context: context,
                        initialTime: const Duration(minutes: 30),
                      );
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
