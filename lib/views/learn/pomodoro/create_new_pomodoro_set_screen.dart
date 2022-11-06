import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_provider.dart';

class CreateNewPomodoroSetScreen extends ConsumerStatefulWidget {
  const CreateNewPomodoroSetScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPomodoroSetScreenState createState() =>
      _CreateNewPomodoroSetScreenState();
}

class _CreateNewPomodoroSetScreenState
    extends ConsumerState<CreateNewPomodoroSetScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    //padding: EdgeInsets.all(24.0),
                    // margin:
                    //    EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0 * 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: theme.mainColorDarker,
                              offset: Offset(4, 4),
                              blurRadius: 15)
                        ]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60,
                          child: Stack(
                            children: [
                              Center(
                                  child: Text("Stwórz własny set Pomodoro!")),
                              Positioned(
                                top: 0,
                                right: 4,
                                bottom: 0,
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.close_rounded,
                                      color: theme.mainColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 24.0,
                              right: 24.0,
                              bottom: 24.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                        child: Text("Czas jednego pomodoro")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(child: TextField()),
                                  ],
                                ),
                                Divider(
                                  color: theme.mainColor,
                                  height: 1,
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Czas przerwy",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(child: TextField()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
