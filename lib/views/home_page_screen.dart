import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/main.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/flash%20cards/flashcard_screen.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/pomodoro_screen.dart';
import 'package:pomodoro_flutter/views/time%20table/time_table_screen.dart';
import 'package:pomodoro_flutter/widgets/home_page_list_item_widget.dart';

import '../constants/app_assets.dart';
import 'change_color_screen.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen>
    with RouteAware {
  late List<Widget> mainScreenTabsList = [];
  @override
  void initState() {
    fillList();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void didPopNext() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final isAluniaTheme = ref.watch(isAluniaThemeProvider);
    final theme = ref.watch(appThemeProvider);
    final redTheme = ref.watch(redThemeProvider);
    final blueTheme = ref.watch(blueThemeProvider);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: theme.gradient),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0 * 2,
                          right: 24.0 * 2,
                          top: 30,
                        ),
                        child: redTheme
                            ? Image.asset(AppAssets.titleRed)
                            : blueTheme
                                ? Image.asset(AppAssets.titleBlue)
                                : Image.asset(AppAssets.titleBrown),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  duration: const Duration(
                                    milliseconds: 350,
                                  ),
                                  child: ChangeColorScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            ref.read(isAluniaThemeProvider.state).state =
                                !ref.read(isAluniaThemeProvider.state).state;
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 50.0,
                              right: 50.0,
                            ),
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: GridView.count(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          //vertical: 24.0,
                        ),
                        crossAxisSpacing: 24.0,
                        mainAxisSpacing: 24.0,
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: mainScreenTabsList,
                      ),
                    ),
                  ),
                ],
              ),
              isAluniaTheme
                  ? Positioned(
                      top: 120,
                      right: 0,
                      child: Image.asset('assets/images/alunia_hii.png',
                          scale: 1.5),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void fillList() {
    mainScreenTabsList = [
      HomePageListItemWidget(
        imageAsset: AppAssets.learnIcon,
        nextScreen: PomodoroScreen(),
        isPomodoroScreen: true,
      ),
      HomePageListItemWidget(
        imageAsset: AppAssets.flashCardIcon,
        nextScreen: FlashCardScreen(),
      ),
      HomePageListItemWidget(
        imageAsset: AppAssets.notepadIcon,
        nextScreen: Container(),
      ),
      HomePageListItemWidget(
        imageAsset: AppAssets.timeTableIcon,
        nextScreen: TimeTableScreen(),
      ),
      HomePageListItemWidget(
        imageAsset: AppAssets.albumIcon,
        nextScreen: Container(),
      ),
      HomePageListItemWidget(
        imageAsset: AppAssets.dayPlanIcon,
        nextScreen: Container(),
      ),
    ];
  }
}
