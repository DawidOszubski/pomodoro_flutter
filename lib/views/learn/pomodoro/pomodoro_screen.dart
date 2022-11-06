import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/timer_screen.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../../constants/app_assets.dart';
import '../../../widgets/custom_button_widget.dart';

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!isTimerSet) {
          setState(() {
            isTimerSet = !isTimerSet;
          });
        }
      }
    });
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  var isTimerSet = false;
  int _currentIndex = 0;
  List<int> learnTime = [25, 35, 45, 60];
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      onTap: () {
        cardKey.currentState!.toggleCard();
      },
      mainColor: theme.mainColor,
      screenTitle: "Pomodoro",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Hero(
              tag: "timer",
              child: Material(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 90.0,
                        animation: false,
                        animationDuration: 1200,
                        lineWidth: 12.0,
                        percent: 1,
                        linearGradient: theme.gradientButton,
                        center: InkWell(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: isTimerSet
                              ? () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      duration: const Duration(
                                        milliseconds: 650,
                                      ),
                                      child: TimerScreen(),
                                    ),
                                  );
                                }
                              : null,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: theme.gradientButton,
                              shape: BoxShape.circle,
                            ),
                            height: 145,
                            child: Center(
                              child: Text(
                                isTimerSet
                                    ? "Start" //learnTime[_currentIndex].toString()
                                    : "Wybierz zestaw",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor:
                            theme.mainColorLighter.withOpacity(0.5),
                        // progressColor: theme.mainColor,
                      ),
                      /* IconButton(
                        onPressed: () {
                          /*    setState(() {
                            isTimerStared = true;
                            _controllerSize.forward();
                          });*/

                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              duration: const Duration(
                                milliseconds: 450,
                              ),
                              child: TimerScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.not_started_outlined,
                          color: theme.mainColor,
                          size: 50,
                        ),
                      ),
                      isTimerSet
                          ? CustomButtonWidget(
                              buttonGradientColor: theme.gradientButton,
                              buttonText: "Start",
                              shadowColor: theme.mainColorDarker,
                              onTap: () {},
                            )
                          : Container(),*/
                    ],
                  ),
                ),
              ),
            ),
          ),
          /* FlipCard(
            key: cardKey,
            flipOnTouch: true,
            front: front(theme.mainColorLighter),
            back: back(),
          ),*/
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: _offsetAnimation,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        buttonCarouselController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: theme.mainColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //width: MediaQuery.of(context).size.width / 1.7,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: theme.backgroundColor,
                            boxShadow: [
                              BoxShadow(
                                  color: theme.mainColorDarker,
                                  offset: const Offset(4, 4),
                                  spreadRadius: 1,
                                  blurRadius: 6),
                              BoxShadow(
                                  color: theme.mainColorLighter,
                                  offset: const Offset(-2, -2),
                                  spreadRadius: 1,
                                  blurRadius: 12),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: CarouselSlider(
                                  items: [
                                    Text(
                                      "Czas jednej\nsekcji\n${learnTime[_currentIndex]}",
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "Czas",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  carouselController: buttonCarouselController,
                                  options: CarouselOptions(
                                    autoPlay: false,
                                    enlargeCenterPage: true,
                                    viewportFraction: 1,
                                    aspectRatio: 1,
                                    initialPage: 0,
                                    onPageChanged: (index, reason) {
                                      _currentIndex = index;
                                      setState(() {
                                        switch (_currentIndex) {
                                          case 0:
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            /* Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Czas jednej\nsekcji",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text("25 min"),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        buttonCarouselController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: theme.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  CustomButtonWidget(
                    buttonGradientColor: theme.gradientButton,
                    buttonText: "Gotowe zestawy",
                    shadowColor: theme.mainColorDarker,
                    onTap: () {
                      if (_controller.isAnimating || _controller.isCompleted) {
                        setState(() {
                          _controller.reverse();
                        });
                      } else {
                        _controller.forward();
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: CustomButtonWidget(
                      buttonGradientColor: theme.gradientButton,
                      buttonText: "Stwóz własny",
                      shadowColor: theme.mainColorDarker,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget front(Color theme) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(5, 5),
                  blurRadius: 11)
            ]),
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 50,
            ),
            height: MediaQuery.of(context).size.width / 2 + 40,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Stack(children: [
                Image.asset(
                  AppAssets.pomodoroTimerHatImage,
                ),
                Image.asset(
                  AppAssets.pomodoroTimerBaseImage,
                ),
                Positioned(
                  left: 25,
                  top: 55,
                  child: Container(
                    height: MediaQuery.of(context).size.width / 3.2,
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                      color: theme,
                    ),
                    child: Center(
                      child: Text(
                        "25 min",
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  AppAssets.pomodoroTimerHatImage,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget back() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(5, 5),
                  blurRadius: 11)
            ]),
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 50,
            ),
            height: MediaQuery.of(context).size.width / 2 + 40,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
                    "Utaw czas swojej nauki POMODORO i zacznij wykorzystywać swój czas w 101% !")),
          ),
        ],
      ),
    );
  }
}
