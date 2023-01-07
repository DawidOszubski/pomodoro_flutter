import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:pomodoro_flutter/widgets/bottom_sheet_base_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../main.dart';
import '../../../models/learn_models/pomodoro_set_model.dart';
import '../../../providers/pomodoro_provider.dart';
import '../../../widgets/custom_button_widget.dart';
import '../../../widgets/pomodoro/pomodoro_set_widget.dart';
import 'create_new_pomodoro_set_screen.dart';

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen>
    with TickerProviderStateMixin, RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    ref.refresh(getPomodoroSetsProvider);
    super.didPopNext();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut))
    ..addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Timer(const Duration(milliseconds: 1000), () {
          setState(() {
            isTimerSet = true;
          });
        });
      }
      if (status == AnimationStatus.reverse) {
        setState(() {
          isTimerSet = false;
        });
      }
    });

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PomodoroSetModel> pomodoroSetList = [
    PomodoroSetModel(
      learnSectionTime: 25,
      breakTime: 5,
    ),
    PomodoroSetModel(
      learnSectionTime: 35,
      breakTime: 8,
    ),
    PomodoroSetModel(
      learnSectionTime: 45,
      breakTime: 12,
    ),
  ];

  PomodoroSetModel? firstSet;

  var isTimerSet = false;
  int _currentIndex = 0;
  List<int> learnTime = [25, 35, 45, 60];
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final pomodoroSet = ref.watch(getPomodoroSetsProvider);
    final repeatCount = ref.watch(timerRepeatCountProvider.notifier).state;
    return BaseScreenWidget(
      resizeToAvoidBottomInsets: false,
      onTap: () {
        BottomSheetWidget.show(
          context,
          Text(
              "Wybierz gotowy zestaw lub utwórz nowy dopasowany do Twoich potrzeb!"),
        );
      },
      mainColor: theme.mainColor,
      screenTitle: "Pomodoro",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: CircularPercentIndicator(
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
                      onTap: () {
                        if (isTimerSet) {
                          print(ref
                              .watch(getPomodoroSetsProvider)
                              .value![_currentIndex]
                              .learnSectionTime);
                          print(ref.watch(timerRepeatCountProvider));

                          /*Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(
                                    milliseconds: 450,
                                  ),
                                  child: TimerScreen(
                                      pomodoroSetModel:
                                          pomodoroSetList[_currentIndex]),
                                ),
                              );*/
                        } else {
                          _controller.forward();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: theme.gradientButton,
                          shape: BoxShape.circle,
                        ),
                        height: 145,
                        child: Center(
                          child: Text(
                            isTimerSet ? "start".tr() : "choseSet".tr(),
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
                    backgroundColor: theme.mainColorLighter.withOpacity(0.5),
                    // progressColor: theme.mainColor,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 24,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: theme.mainColorDarker,
                          offset: Offset(1, 2),
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.airplanemode_active_outlined,
                        color: theme.mainColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            child: SlideTransition(
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
                          horizontal: 24.0, vertical: 24),
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
                            child: pomodoroSet.when(
                                data: (pomodoroSet) {
                                  setState(() {
                                    if (pomodoroSet!.isNotEmpty) {
                                      firstSet = pomodoroSet.first;
                                    }
                                  });
                                  return CarouselSlider(
                                    items: pomodoroSet!.isNotEmpty
                                        ? List.generate(
                                            pomodoroSet.length,
                                            (index) => PomodoroSetWidget(
                                              pomodoroSet: pomodoroSet[index],
                                            ),
                                          )
                                        : [
                                            Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                          "noElements.noPomodoroSet"
                                                              .tr(),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                    carouselController:
                                        buttonCarouselController,
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      viewportFraction: 1,
                                      aspectRatio: 1,
                                      initialPage: 0,
                                      onPageChanged: (index, reason) {
                                        ref
                                            .read(timerRepeatCountProvider
                                                .notifier)
                                            .state = 1;
                                        _currentIndex = index;
                                      },
                                    ),
                                  );
                                },
                                error: (err, s) => CarouselSlider(
                                      items: [
                                        PomodoroSetWidget(
                                            pomodoroSet: pomodoroSetList[0]),
                                        PomodoroSetWidget(
                                            pomodoroSet: pomodoroSetList[1]),
                                        PomodoroSetWidget(
                                            pomodoroSet: pomodoroSetList[2]),
                                      ],
                                      carouselController:
                                          buttonCarouselController,
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
                                loading: () {
                                  return CarouselSlider(
                                    items: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.withOpacity(0.2),
                                        highlightColor:
                                            Colors.white.withOpacity(0.4),
                                        period: Duration(milliseconds: 1200),
                                        child: Container(
                                          child: PomodoroSetWidget(
                                              pomodoroSet: pomodoroSetList[0]),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                    carouselController:
                                        buttonCarouselController,
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
                                  );
                                }),
                          ),
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
          ),
          /* SizedBox(
            height: 24,
          ),*/
          Column(
            children: [
              CustomButtonWidget(
                theme: theme,
                buttonText: "Gotowe zestawy",
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
                  theme: theme,
                  buttonText: "Stwórz własny",
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: CreateNewPomodoroSetScreen()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
