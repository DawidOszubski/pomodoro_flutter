import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/home_page_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_assets.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //initializeDateFormatting('pl');
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(
    ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('pl', 'PL'), Locale('en', 'US')],
          path: 'translations',
          fallbackLocale: const Locale('pl', 'PL'),
          startLocale: const Locale('pl', 'PL'),
          child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> getThemePrefs() async {
      final prefs = await SharedPreferences.getInstance();
      final theme = prefs.getString('theme');
      if (theme == null) {
        ref.read(redThemeProvider.state).state = true;
      } else {
        if (theme == "red") {
          ref.read(redThemeProvider.state).state = true;
        }
        if (theme == 'blue') {
          ref.read(blueThemeProvider.state).state = true;
        }
        if (theme == 'brown') {
          ref.read(brownThemeProvider.state).state = true;
        }
      }
    }

    getThemePrefs();
    final theme = ref.watch(appThemeProvider);
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
        primaryColor: theme.mainColor,
        indicatorColor: theme.mainColor,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: theme.mainColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => theme.mainColor,
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: theme.mainColor,
        ),
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: const AnimatedSplash(),
    );
  }
}

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: double.infinity,
        curve: Curves.bounceInOut,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: const Duration(milliseconds: 1500),
        duration: 800,
        splash: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppAssets.mainTitleImage,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              //SizedBox(height: 120.0),
              Center(
                child: Image.asset(
                  AppAssets.appIcon,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ],
          ),
        ),
        nextScreen: HomePageScreen());
  }
}
