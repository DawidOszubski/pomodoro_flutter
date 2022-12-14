import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/pomodoro_screen.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/test_screen.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/zadanka_screen.dart';
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
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final isAluniaTheme = ref.watch(isAluniaThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "Czas na naukę",
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LearnScreenListItemWidget(
                  title: "Pomodoro",
                  nextScreen: PomodoroScreen(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                LearnScreenListItemWidget(
                  title: "Testy",
                  nextScreen: TestScreen(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                LearnScreenListItemWidget(
                  title: "Zadanka",
                  nextScreen: ZadankaScreen(),
                ),
              ],
            ),
          ),
          isAluniaTheme
              ? Positioned(
                  bottom: -5,
                  right: -5,
                  child: Image.asset(
                    AppAssets.aluniaHmmImage,
                    scale: 0.8,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
