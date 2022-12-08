import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constants/app_styles.dart';
import '../../constants/app_themes.dart';
import '../../models/flashcards_model/flash_card_model.dart';
import '../../providers/flashcard_provider.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/pop_up_widget.dart';
import '../../widgets/text_field_widget.dart';

class ChangeFlashcardSetNameScreen extends ConsumerWidget {
  const ChangeFlashcardSetNameScreen({
    Key? key,
    required this.theme,
    required this.flashcard,
  }) : super(key: key);

  final AppThemeModel theme;
  final FlashCardModel flashcard;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashCardController = TextEditingController();

    final flashCardValidator = MultiValidator([
      RequiredValidator(errorText: 'Pole nie może być puste'),
      MaxLengthValidator(255, errorText: "Nazwa za długa"),
    ]);

    return PopUpWidget(
      title: "Zmień nazwę fiszek",
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              buttonText: "Zmień",
              buttonGradientColor: theme.gradientButton,
              shadowColor: theme.mainColorDarker,
              onTap: () {
                if (flashCardController.text.isNotEmpty) {
                  final flashCard = FlashCardModel(
                    id: flashcard.id,
                    title: flashCardController.text,
                    subject: flashcard.subject,
                    progressCount: flashcard.progressCount,
                    flashcardCount: flashcard.flashcardCount,
                  );

                  ref.read(changeNameFlashcardProvider(flashCard));
                  Navigator.pop(context);
                  ref.refresh(getFlashcardSetsProvider);
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
    );
  }
}
