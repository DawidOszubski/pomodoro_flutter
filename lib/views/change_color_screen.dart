import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class ChangeColorScreen extends ConsumerStatefulWidget {
  const ChangeColorScreen({Key? key}) : super(key: key);

  @override
  _ChangeColorScreenState createState() => _ChangeColorScreenState();
}

class _ChangeColorScreenState extends ConsumerState<ChangeColorScreen> {
  @override
  Widget build(BuildContext context) {
    final isAluniaTheme = ref.watch(blueThemeProvider);
    final isPomodoroTheme = ref.watch(redThemeProvider);
    final isMainTheme = ref.watch(brownThemeProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 60.0,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(blueThemeProvider.state).state = false;
                              ref.read(brownThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = true;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              color: AppColors.mainColorRed,
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
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(blueThemeProvider.state).state = true;
                              ref.read(brownThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = false;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              color: AppColors.mainColorBlue,
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
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              ref.read(blueThemeProvider.state).state = false;
                              ref.read(redThemeProvider.state).state = false;
                              ref.read(brownThemeProvider.state).state = true;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              color: AppColors.mainColorBrown,
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
                                color: Colors.green,
                                size: 40,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.setLocale(Locale('en', 'US'));
                      },
                      child: Text("klik".tr())),
                  ElevatedButton(
                      onPressed: () {
                        context.setLocale(Locale('pl', 'PL'));
                      },
                      child: Text("klik".tr()))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
