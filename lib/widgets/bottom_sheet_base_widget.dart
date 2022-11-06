import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pomodoro_flutter/constants/app_colors.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

class BottomSheetBaseWidget extends ConsumerStatefulWidget {
  const BottomSheetBaseWidget({
    Key? key,
    required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  _BottomSheetBaseWidgetState createState() => _BottomSheetBaseWidgetState();
}

class _BottomSheetBaseWidgetState extends ConsumerState<BottomSheetBaseWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Container(
        margin: const EdgeInsets.only(
          top: 40.0,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24 * 3,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        "Sesje Nauki Pomodoro",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 24, left: 24, bottom: 12),
                        child: Icon(
                          Icons.close_rounded,
                          color: theme.mainColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetWidget {
  static Future<void> show(BuildContext context, Widget body) {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheetBaseWidget(body: body),
    );
  }
}
