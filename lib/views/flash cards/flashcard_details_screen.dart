import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flashcard_item_model.dart';
import 'package:pomodoro_flutter/providers/flashcard_provider.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';
import 'package:pomodoro_flutter/widgets/rounded_add_button_widget.dart';
import 'package:pomodoro_flutter/widgets/search_bar_widget.dart';

import '../../constants/app_styles.dart';
import '../../models/flashcards_model/flash_card_model.dart';
import '../../providers/search_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import 'add_new.dart';

class FlashCardDetailsScreen extends ConsumerStatefulWidget {
  const FlashCardDetailsScreen({
    Key? key,
    required this.flashCard,
  }) : super(key: key);

  final FlashCardModel flashCard;

  @override
  _FlashCardDetailsScreenState createState() => _FlashCardDetailsScreenState();
}

class _FlashCardDetailsScreenState extends ConsumerState<FlashCardDetailsScreen>
    with TickerProviderStateMixin {
  var isEmpty = false;
  final searchController = TextEditingController();
  var scale = 0.0;
  var minHeight = 100.0;
  var maxHeight = 200.0;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final isSearch = ref.watch(isSearchProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        /* _controller
            .reverse()
            .then((value) => ref.read(isSearchProvider.state).state = false);*/
      },
      child: BaseScreenWidget(
        mainColor: theme.mainColor,
        screenTitle: widget.flashCard.title,
        resizeToAvoidBottomInsets: false,
        body: isEmpty
            ? noItemsWidget(
                theme: theme,
              )
            : Stack(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              !isSearch
                                  ? CustomButtonWidget(
                                      buttonText: "Nauka",
                                      buttonGradientColor: theme.gradientButton,
                                      shadowColor: theme.mainColorDarker,
                                      onTap: () {},
                                    )
                                  : Container(),
                              SizedBox(
                                width: !isSearch ? 8.0 : 0.0,
                              ),
                              Expanded(
                                child: ScaleTransition(
                                  scale: _animation,
                                  alignment: Alignment.centerRight,
                                  child: isSearch
                                      ? Stack(
                                          children: [
                                            SearchBarWidget(
                                              autofocus: true,
                                              controller: searchController,
                                              color: theme.mainColor,
                                              hint: "Szukaj...",
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      _controller
                                                          .reverse()
                                                          .then((value) {
                                                        ref
                                                            .read(
                                                                isSearchProvider
                                                                    .state)
                                                            .state = false;

                                                        setState(() {
                                                          searchController
                                                              .clear();
                                                        });
                                                      });
                                                    });
                                                  },
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(12.0),
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        )
                                      : Container(),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _controller.forward();
                                  ref.read(isSearchProvider.state).state = true;
                                },
                                child: !isSearch
                                    ? Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Icon(
                                          Icons.search,
                                          color: theme.mainColor,
                                          size: 30,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(
                                    milliseconds: 350,
                                  ),
                                  child: AddNew(),
                                ),
                              );
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: minHeight,
                                maxHeight: maxHeight,
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
                                        color: theme.mainColorDarker
                                            .withOpacity(0.6),
                                        offset: const Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        spreadRadius: 0,
                                        blurRadius: 8,
                                      ),
                                    ]),
                                child: Text("text"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          final flashcard = FlashcardItemModel(
                            question: "Jakieś pytanie",
                            answerText: "Jakaś odpowiedź",
                            flashcardSetId: widget.flashCard.id!,
                            answerMultipleChoice: null,
                            answerTF: null,
                          );
                          ref.read(addNewFlashcardItemProvider(flashcard));
                          /* Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: AddNewFlashCardScreen(),
                            ),
                          );*/
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget noItemsWidget({
    required AppThemeModel theme,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: theme.mainColor,
            ),
            SizedBox(
              width: 3.0,
            ),
            Text("Brak stworzonych fiszek"),
          ],
        ),
        InkWell(
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Stwórz",
                style: AppStyles.secondaryButtonStyle
                    .copyWith(color: theme.mainColor),
              ) /*CustomButtonWidget(
              buttonText: "Stwórz",
              buttonGradientColor: theme.gradientButton,
              shadowColor: theme.mainColorDarker,
              onTap: () {},
            ),*/
              ),
        )
      ],
    );
  }
}
