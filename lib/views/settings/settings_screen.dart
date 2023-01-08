import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final isAluniaTheme = ref.watch(blueThemeProvider);
    final isPomodoroTheme = ref.watch(redThemeProvider);
    final isMainTheme = ref.watch(brownThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "settings.title".tr(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2, 2),
                      blurRadius: 8)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "settings.theme".tr(),
                    style: AppStyles.descriptionStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('theme', "red");
                              ref.read(blueThemeProvider.state).state = false;
                              ref.read(brownThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = true;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.mainColorRed,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Visibility(
                            visible: isPomodoroTheme,
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('theme', "blue");
                              ref.read(blueThemeProvider.state).state = true;
                              ref.read(brownThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.mainColorBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Visibility(
                            visible: isAluniaTheme,
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('theme', "brown");
                              ref.read(blueThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = false;
                              ref.read(brownThemeProvider.state).state = true;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.mainColorBrown,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                          Visibility(
                            visible: isMainTheme,
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(2, 2),
                      blurRadius: 8)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "settings.language".tr(),
                    style: AppStyles.descriptionStyle,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.setLocale(const Locale('pl', 'PL'));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              /*  border:
                                  Border.all(color: theme.mainColor, width: 2),*/
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ]),
                          child: Image.asset(AppAssets.polandFlagIcon),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      InkWell(
                        onTap: () {
                          context.setLocale(const Locale('en', 'US'));
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              /* border:
                                  Border.all(color: theme.mainColor, width: 2),*/
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: const Offset(2, 2),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ]),
                          child: Image.asset(AppAssets.englandFlagIcon),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
