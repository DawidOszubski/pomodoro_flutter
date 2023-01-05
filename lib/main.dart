import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/home_page_screen.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  //initializeDateFormatting('pl');
  await Firebase.initializeApp();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);
  runApp(
    ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('pl', 'PL')],
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
    final theme = ref.watch(appThemeProvider);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: theme.mainColor,
        indicatorColor: theme.mainColor,
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
      home: HomePageScreen(),
    );
  }
}
