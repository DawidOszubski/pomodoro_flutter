import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_styles.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/flash_card_model.dart';
import 'package:pomodoro_flutter/views/flash%20cards/flashcard_details_screen.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/flash_card_item_widget.dart';
import 'package:pomodoro_flutter/widgets/pop_up_widget.dart';
import 'package:pomodoro_flutter/widgets/text_field_widget.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';

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
          ListView.builder(
            itemCount: flashcards.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: deleteWidget(theme, index),
                    ),
                  );
                },
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        child: FlashCardDetailsScreen(
                          title: flashcards[index].title,
                        )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  child: FlashCardItemWidget(
                    flashcard: flashcards[index],
                    theme: theme,
                  ),
                ),
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
                  flashCardController.clear();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: PopUpWidget(
                        title: "Stwórz nowe fiszki",
                        body: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: TextFieldWidget(
                                  validator: flashCardValidator,
                                  textFieldTitle: "Nazwa fiszek",
                                  controller: flashCardController,
                                  color: theme.mainColor,
                                  autofocus: true,
                                  hint: "Wpisz nazwę fiszek",
                                ),
                              ),
                              const SizedBox(
                                height: 24.0 * 2,
                              ),
                              CustomButtonWidget(
                                buttonText: "Dodaj",
                                buttonGradientColor: theme.gradientButton,
                                shadowColor: theme.mainColorDarker,
                                onTap: () {
                                  if (flashCardController.text.isNotEmpty) {
                                    final flashCard = FlashCardModel(
                                        id: 1,
                                        title: flashCardController.text,
                                        subject: "subject",
                                        progressCount: 0,
                                        flashcardCount: 15);
                                    setState(() {
                                      Navigator.pop(context);
                                      flashcards.add(flashCard);
                                    });
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Anuluj",
                                    style: AppStyles.secondaryButtonStyle
                                        .copyWith(color: theme.mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        mainColor: theme.mainColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      screenTitle: "Fiszki",
      resizeToAvoidBottomInsets: false,
    );
  }

  Widget deleteWidget(AppThemeModel theme, int index) {
    return PopUpWidget(
        title: "Usuwanie fiszek",
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
                      Navigator.pop(context);
                      Timer(
                        Duration(milliseconds: 400),
                        () => setState(() {
                          flashcards.removeAt(index);
                        }),
                      );
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
