import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/notepad/notepad_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';

class NotepadScreen extends ConsumerStatefulWidget {
  const NotepadScreen({Key? key}) : super(key: key);

  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends ConsumerState<NotepadScreen> {
  final list = [
    "dawwwwww",
    "sa",
    "aaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa dddddddddd",
    "dawwwwww",
    "sa",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "notepad.title".tr(),
      body: Stack(
        children: [
          MasonryGridView.builder(
            padding: const EdgeInsets.only(
              bottom: 24.0,
              top: 12.0,
              left: 24.0,
              right: 24.0,
            ),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: 12,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  NotepadWidget(
                    notepad: NotepadModel(
                        title: "dsadawd",
                        description: "dawdawd",
                        date: DateTime.now().toString()),
                  ),
                  index == 11
                      ? const SizedBox(
                          height: 80,
                        )
                      : Container(),
                ],
              );
            },
          ),
          Positioned(
            bottom: 24.0,
            right: 24.0,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RoundedAddButtonWidget(
                theme: theme,
                onTap: () {
                  /* Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: CreateNewFlashcardSetScreen(theme: theme),
                    ),
                  );*/
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
