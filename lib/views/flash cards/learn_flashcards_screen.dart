import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

import '../../models/flashcards_model/flashcard_item_model.dart';
import '../../providers/theme_provider.dart';

class LearnFlashcardsScreen extends ConsumerStatefulWidget {
  const LearnFlashcardsScreen({
    Key? key,
    required this.flashcards,
    required this.index,
  }) : super(key: key);

  final List<FlashcardItemModel> flashcards;
  final int index;

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends ConsumerState<LearnFlashcardsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final flashcardList = List.generate(
        widget.flashcards.length,
        (index) =>
            flipCardWidget(theme: theme, flashcard: widget.flashcards[index]));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3 + 50,
                  ),
                ),
                Center(
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height / 2,
                    child: CarouselSlider(
                        items: flashcardList,
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 3 + 50,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: widget.index,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        )), /*FlipCard(
                      fill: Fill
                          .fillBack, // Fill the back side of the card to make in the same size as the front.
                      direction: FlipDirection.HORIZONTAL, // default
                      front: frontPage(theme: theme),
                      back: backPage(theme: theme),
                    ),*/
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget flipCardWidget(
      {required AppThemeModel theme, required FlashcardItemModel flashcard}) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL, // default
      front: frontPage(theme: theme, flashcard: flashcard),
      back: backPage(theme: theme, flashcard: flashcard),
    );
  }

  Widget frontPage(
      {required AppThemeModel theme, required FlashcardItemModel flashcard}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height / 3,
              maxHeight: MediaQuery.of(context).size.height / 3,
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(flashcard.question),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backPage(
      {required AppThemeModel theme, required FlashcardItemModel flashcard}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height / 3,
              maxHeight: MediaQuery.of(context).size.height / 2,
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(flashcard.answerText!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
