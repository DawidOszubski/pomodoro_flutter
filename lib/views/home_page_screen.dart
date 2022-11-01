import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/flashcard_screen.dart';
import 'package:pomodoro_flutter/views/learn/learn_screen.dart';
import 'package:pomodoro_flutter/views/time%20table/time_table_screen.dart';
import 'package:pomodoro_flutter/widgets/home_page_list_item_widget.dart';

import '../constants/app_assets.dart';
import 'change_color_screen.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
/*  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(2, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
    begin: const Offset(4.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller2,
    curve: Curves.elasticOut,
  ));
  late final AnimationController _controller3 = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation3 = Tween<Offset>(
    begin: const Offset(6.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller3,
    curve: Curves.elasticOut,
  ));*/
  late List<Widget> mainScreenTabsList = [];
  @override
  void initState() {
    fillList();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    /*_controller.dispose();
    _controller2.dispose();
    _controller3.dispose();*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAluniaTheme = ref.watch(isAluniaThemeProvider);
    final themeData = ref.watch(appThemeProvider);
    //final primaryColor = themeData["primaryColor"];
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
      _controller2.forward();
      _controller3.forward();
    });*/
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: themeData.mainColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: themeData.mainColor,
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
                        child: isAluniaTheme
                            ? Image.asset(AppAssets.titleAlunia)
                            : Image.asset(AppAssets.titleMain),
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
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
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
                            height: 60,
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
        nextScreen: LearnScreen(),
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
