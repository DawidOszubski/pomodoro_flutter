import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flashcard_item_model.dart';

import '../../views/flash cards/add_new_flashcard_screen.dart';

class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    Key? key,
    required this.theme,
    required this.flashcard,
  }) : super(key: key);

  final AppThemeModel theme;
  final FlashcardItemModel flashcard;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(
                2.0,
                2.0,
              ),
              spreadRadius: 0,
              blurRadius: 4,
            ),
            BoxShadow(
              color: theme.mainColorDarker.withOpacity(0.6),
              offset: const Offset(
                3.0,
                3.0,
              ),
              spreadRadius: 0,
              blurRadius: 8,
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                softWrap: true,
                flashcard.question,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: AddNewFlashCardScreen(
                        flashcardId: flashcard.id!,
                        flashcard: flashcard,
                      ),
                      type: PageTransitionType.fade));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                Icons.edit,
                size: 20,
                color: theme.mainColorDarker,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
