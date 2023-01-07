import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/flashcard_provider.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/flash_card_item_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/flashcards_model/flash_card_model.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';
import 'add_new_flashcard_set_screen.dart';

class FlashCardScreen extends ConsumerStatefulWidget {
  const FlashCardScreen({Key? key}) : super(key: key);

  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends ConsumerState<FlashCardScreen> {
  final List<FlashCardModel> flashcards = [];
  final flashCardController = TextEditingController();
  var offset = 0.0;

  final flashCardValidator = MultiValidator([
    RequiredValidator(errorText: 'Pole nie może być puste'),
    MaxLengthValidator(255, errorText: "Nazwa za długa")
  ]);
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final getFlashcards = ref.watch(getFlashcardSetsProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      onTap: () {
        //  cardKey.currentState!.toggleCard();
      },
      actionIcon: Icon(
        Icons.search,
        color: Colors.white,
      ),
      body: Stack(
        children: [
          getFlashcards.when(
              data: (flashcards) {
                if (flashcards != null) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: flashcards.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12.0,
                        ),
                        child: Column(
                          children: [
                            FlashCardItemWidget(
                              flashcard: flashcards[index],
                              theme: theme,
                            ),
                            index == flashcards.length - 1
                                ? const SizedBox(
                                    height: 100,
                                  )
                                : Container()
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Flexible(
                          child: Text(
                            "noElements.text".tr(
                              args: [
                                "noElements.noFlashcards".tr(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              error: (err, s) => Center(
                    child: Container(
                      child: Text("Error"),
                    ),
                  ),
              loading: () {
                return ListView.builder(
                  itemCount: 5,
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
                        child: FlashCardItemWidget(
                          flashcard: FlashCardModel(title: "", subject: ""),
                          theme: theme,
                        ),
                      ),
                    );
                  },
                );
              }),
          Positioned(
            bottom: 24.0,
            right: 24.0,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RoundedAddButtonWidget(
                theme: theme,
                onTap: () {
                  flashCardController.clear();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: CreateNewFlashcardSetScreen(theme: theme),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      screenTitle: "flashcards".tr(),
      resizeToAvoidBottomInsets: false,
    );
  }
}
