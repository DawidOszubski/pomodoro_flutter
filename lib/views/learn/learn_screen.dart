import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/pomodoro_screen.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../constants/app_assets.dart';
import '../../widgets/learn_screen/learn_screen_list_item_widget.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "Czas na naukę",
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: const [
                LearnScreenListItemWidget(
                  title: "Pomodoro",
                  nextScreen: PomodoroScreen(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                LearnScreenListItemWidget(
                  title: "Test",
                  nextScreen: PomodoroScreen(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                LearnScreenListItemWidget(
                  title: "Inne",
                  nextScreen: PomodoroScreen(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: Image.asset(
              AppAssets.aluniaHmmImage,
              scale: 0.8,
            ),
          ),
        ],
      ),
    );

    /*Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Czas na naukę"),
        centerTitle: true,
        foregroundColor: theme.backgroundColor,
        backgroundColor: theme.mainColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LearnScreenListItemWidget(title: "Pomodoro"),
                LearnScreenListItemWidget(title: "Test"),
                LearnScreenListItemWidget(title: "Inne"),
              ],
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: Image.asset(
                AppAssets.aluniaHmmImage,
                scale: 0.8,
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}
