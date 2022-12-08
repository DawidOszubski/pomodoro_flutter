import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flash_card_model.dart';

import '../../constants/app_styles.dart';
import '../../providers/flashcard_provider.dart';
import '../../widgets/pop_up_widget.dart';

class DeleteFlashcardSetScreen extends ConsumerWidget {
  const DeleteFlashcardSetScreen({
    Key? key,
    required this.theme,
    required this.flashcard,
  }) : super(key: key);

  final AppThemeModel theme;
  final FlashCardModel flashcard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopUpWidget(
        title: "Usuń fiszki",
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Czy jestes pewien, że chcesz usunąć te fiszki?",
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
                      ref.watch(deleteFlashcardProvider(flashcard));
                      Navigator.pop(context);
                      ref.refresh(getFlashcardSetsProvider);
                      /*Timer(
                        Duration(milliseconds: 400),
                        () => setState(() {
                          flashcards.removeAt(index);
                        }),
                      );*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "TAK",
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: theme.mainColor),
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
                        "NIE",
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: theme.mainColor),
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
        mainColor: theme.mainColor);
  }
}
