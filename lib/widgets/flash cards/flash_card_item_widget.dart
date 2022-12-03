import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

import '../../models/flashcards_model/flash_card_model.dart';

class FlashCardItemWidget extends StatefulWidget {
  const FlashCardItemWidget({
    Key? key,
    required this.flashcard,
    required this.theme,
  }) : super(key: key);

  final FlashCardModel flashcard;
  final AppThemeModel theme;

  @override
  State<FlashCardItemWidget> createState() => _FlashCardItemWidgetState();
}

class _FlashCardItemWidgetState extends State<FlashCardItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.backgroundColor,
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
            color: widget.theme.mainColorDarker.withOpacity(0.6),
            offset: const Offset(
              3.0,
              3.0,
            ),
            spreadRadius: 0,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 24.0),
                child: Text(
                  widget.flashcard.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              InkWell(
                onTap: () {
                  print("tap");
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.edit,
                    size: 20,
                    color: widget.theme.mainColorDarker,
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.flashcard.progressCount != 0,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Progres:",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 4.0,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: (widget.flashcard.progressCount != 0 &&
                              widget.flashcard.flashcardCount != 0)
                          ? (widget.flashcard.progressCount /
                              widget.flashcard.flashcardCount)
                          : 0,
                      color: widget.theme.mainColor,
                      backgroundColor:
                          widget.theme.mainColorLighter.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.flashcard.flashcardCount != null &&
                widget.flashcard.flashcardCount! > 0,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Liczba fiszek: ${widget.flashcard.flashcardCount}",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget deleteWidget(BuildContext? context) {
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      return Container(
        decoration: BoxDecoration(
          color: widget.theme.mainColor,
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        height: box.size.height,
        width: box.size.width,
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Icon(
                Icons.delete_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
