import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

import '../../../constants/app_assets.dart';

class PomodoroScreen extends ConsumerStatefulWidget {
  const PomodoroScreen({Key? key}) : super(key: key);

  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends ConsumerState<PomodoroScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Pomodoro"),
        centerTitle: true,
        foregroundColor: theme.backgroundColor,
        backgroundColor: theme.mainColor,
        actions: [
          InkWell(
            onTap: () {
              cardKey.currentState!.toggleCard();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Icon(Icons.help_outline_outlined),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlipCard(
              key: cardKey,
              flipOnTouch: false,
              front: front(theme.mainColorLighter),
              back: back(),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 12,
                    top: 24,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.mainColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(5, 5),
                          blurRadius: 11)
                    ],
                  ),
                  child: Text("Wybierz gotowy zestaw"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 24,
                    top: 12,
                  ),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.mainColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(5, 5),
                          blurRadius: 11)
                    ],
                  ),
                  child: Text("Dostosuj swoje wybory"),
                ),
              ],
            ),
          ],
        ),
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
              vertical: 40,
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
              vertical: 40,
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
