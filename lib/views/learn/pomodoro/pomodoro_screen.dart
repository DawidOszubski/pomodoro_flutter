import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../../constants/app_assets.dart';
import '../../../widgets/custom_button_widget.dart';

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(1, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          FlipCard(
            key: cardKey,
            flipOnTouch: true,
            front: front(theme.mainColorLighter),
            back: back(),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
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
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              CustomButtonWidget(
                buttonColor: theme.mainColor,
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
                  buttonColor: theme.mainColor,
                  buttonText: "Dostosuj",
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
