import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/enum/flashcard_enum.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/big_input_widget.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/checkbox_answer_widget.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_styles.dart';
import '../../models/flashcards_model/flashcard_item_model.dart';
import '../../providers/flashcard_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/notification_widget.dart';

class AddNewFlashCardScreen extends ConsumerStatefulWidget {
  const AddNewFlashCardScreen({
    Key? key,
    required this.flashcardId,
    this.flashcard,
  }) : super(key: key);

  final int flashcardId;
  final FlashcardItemModel? flashcard;

  @override
  _AddNewFlashCardScreenState createState() => _AddNewFlashCardScreenState();
}

class _AddNewFlashCardScreenState extends ConsumerState<AddNewFlashCardScreen> {
  final picker = ImagePicker();

  File? image;
  var loadImage = false;
  bool? isTrue;
  String selectedAnswerType = "Otwarte";
  AnswerType answerType = AnswerType.open;
  final frontPageController = TextEditingController();
  final backPagController = TextEditingController();
  final List<String> items = [
    'Otwarte',
    'Wielokrotnego wyboru',
    'Prawda/Fałsz'
  ];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.flashcard != null) {
      frontPageController.text = widget.flashcard!.question;
      backPagController.text = widget.flashcard!.answerText!;
    }
    super.initState();
  }

  @override
  void dispose() {
    frontPageController.dispose();
    backPagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNotificationVisible = ref.watch(isNotificationVisibleProvider);
    final theme = ref.watch(appThemeProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseScreenWidget(
        screenTitle: "Dodaj nową fiszkę",
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppConstants.screenSizeTopPadding,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Strona przednia", //"Pytanie",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: BigInputWidget(
                        controller: frontPageController,
                        color: theme.mainColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InkWell(
                            onTap: () async {
                              try {
                                await pickImage();
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Dodaj obraz",
                                style: AppStyles.secondaryButtonStyle
                                    .copyWith(color: theme.mainColor),
                              ),
                            )),
                      ),
                    ),
                    image != null
                        ? Image.file(
                            image!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    const SizedBox(
                      height: 24.0 * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Strona tylnia", // "Odpowiedź",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    /* Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: CustomDropdownButton2(
                        buttonWidth: double.infinity,
                        dropdownPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                        dropdownWidth: MediaQuery.of(context).size.width - 48,
                        buttonPadding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        hint: 'Wybierz rodzaj odpowiedzi',
                        iconEnabledColor: theme.mainColor,
                        icon: const RotatedBox(
                            quarterTurns: 1,
                            child: Icon(Icons.arrow_forward_ios_outlined)),
                        iconSize: 20,
                        dropdownItems: items,
                        value: selectedAnswerType,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswerType = value!;
                            isTrue = null;
                            if (value == items[0]) {
                              answerType = AnswerType.open;
                            } else if (value == items[1]) {
                              answerType = AnswerType.multipleChoice;
                            } else {
                              isTrue = true;
                              answerType = AnswerType.tf;
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),*/
                    answerTypeWidget(theme: theme, answerType: answerType),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButtonWidget(
                                buttonText: widget.flashcard != null ? "Zmień" :'Dodaj',
                                onTap: frontPageController.text.isNotEmpty &&
                                        backPagController.text.isNotEmpty
                                    ? () {
                                        if (widget.flashcard != null) {
                                          final flashcard = FlashcardItemModel(
                                            id: widget.flashcard!.id,
                                            question: frontPageController.text,
                                            answerText: backPagController.text,
                                            flashcardSetId: widget.flashcardId,
                                          );
                                          ref.read(updateFlashcardItemProvider(
                                              flashcard));

                                          Navigator.pop(context);
                                        } else {
                                          final flashcard = FlashcardItemModel(
                                            question: frontPageController.text,
                                            answerText: backPagController.text,
                                            flashcardSetId: widget.flashcardId,
                                          );
                                          ref.read(addNewFlashcardItemProvider(
                                              flashcard));
                                          setState(() {
                                            frontPageController.clear();
                                            backPagController.clear();
                                          });
                                          ref
                                              .read(
                                                  isNotificationVisibleProvider
                                                      .state)
                                              .state = true;
                                          Timer(Duration(seconds: 2), () {
                                            ref
                                                .read(
                                                    isNotificationVisibleProvider
                                                        .state)
                                                .state = false;
                                          });
                                        }
                                      }
                                    : null,
                                buttonGradientColor: theme.gradientButton,
                                shadowColor: theme.mainColorDarker),
                            const SizedBox(
                              height: 12.0,
                            ),
                            /* InkWell(
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
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                isNotificationVisible
                    ? NotificationWidget(text: "Pomyślnie dodano nową fiszkę")
                    : Container(),
              ],
            ),
          ),
        ),
        mainColor: theme.mainColor,
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) {
        return;
      } else {
        final imageTmp = File(image.path);
        setState(() {
          this.image = imageTmp;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Widget answerTypeWidget(
      {required AnswerType answerType, required AppThemeModel theme}) {
    switch (answerType) {
      case AnswerType.open:
        return answerText(theme: theme);
      case AnswerType.multipleChoice:
        return answerMultiple(theme: theme);
      case AnswerType.tf:
        return answerTF(theme: theme);
    }
  }

  Widget answerText({required AppThemeModel theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BigInputWidget(
        controller: backPagController,
        color: theme.mainColor,
      ),
    );
  }

  Widget answerTF({required AppThemeModel theme}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (!isTrue!) {
                    setState(() {
                      isTrue = true;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.mainColor, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isTrue! ? theme.mainColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text("PRAWDA"),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (isTrue!) {
                    setState(() {
                      isTrue = false;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: theme.mainColor, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: !isTrue! ? theme.mainColor : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text("FAŁSZ"),
            ],
          ),
        ],
      ),
    );
  }

  Widget answerMultiple({required AppThemeModel theme}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 24.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CheckboxAnswerWidget(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: TextField(),
              )),
            ],
          )
        ],
      ),
    );
  }

  Widget answerNotChosen() {
    return Container(
      width: double.infinity,
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(child: Text("PRAWDA / FAŁSZ")),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey, width: 1),
                  right: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Center(child: Text("Zamknięte")),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(child: Text("Otwarte")),
            ),
          ),
        ],
      ),
    );
  }
}
