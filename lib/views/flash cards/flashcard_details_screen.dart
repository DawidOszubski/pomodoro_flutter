import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/main.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flashcard_item_model.dart';
import 'package:pomodoro_flutter/providers/flashcard_provider.dart';
import 'package:pomodoro_flutter/widgets/rounded_add_button_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_styles.dart';
import '../../models/flashcards_model/flash_card_model.dart';
import '../../providers/search_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/flash cards/flashcard_widget.dart';
import 'add_new_flashcard_screen.dart';
import 'learn_flashcards_screen.dart';

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
    with TickerProviderStateMixin, RouteAware {
  var isEmpty = false;
  final searchController = TextEditingController();
  var scale = 0.0;
  var minHeight = 100.0;
  var maxHeight = 200.0;
  /* late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );*/

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    ref.refresh(getFlashcardsProvider(widget.flashCard.id!));
    super.didPopNext();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final isSearch = ref.watch(isSearchProvider);
    final getFlashcards =
        ref.watch(getFlashcardsProvider(widget.flashCard.id!));
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
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  /* Row(
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
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _controller
                                                  .reverse()
                                                  .then((value) {
                                                ref
                                                    .read(isSearchProvider
                                                        .state)
                                                    .state = false;

                                                setState(() {
                                                  searchController.clear();
                                                });
                                              });
                                            });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
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
                  ),*/
                  Expanded(
                    child: getFlashcards.when(
                        data: (flashcards) {
                          if (flashcards != null) {
                            return ListView.builder(
                              itemCount: flashcards.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 12.0,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              duration: const Duration(
                                                milliseconds: 100,
                                              ),
                                              child: LearnFlashcardsScreen(
                                                  flashcards: flashcards,
                                                  index: index),
                                            ),
                                          );
                                        },
                                        child: FlashcardWidget(
                                          theme: theme,
                                          flashcard: flashcards[index],
                                        ),
                                      ),
                                    ),
                                    index == flashcards.length - 1
                                        ? const SizedBox(
                                            height: 100,
                                          )
                                        : Container()
                                  ],
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Container(
                                child: Text("Brak elementów do wyświetlenia"),
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
                                  child: FlashcardWidget(
                                    theme: theme,
                                    flashcard: FlashcardItemModel(
                                      flashcardSetId: 0,
                                      question: '',
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
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
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: AddNewFlashCardScreen(
                            flashcardId: widget.flashCard.id!),
                      ),
                    );
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
