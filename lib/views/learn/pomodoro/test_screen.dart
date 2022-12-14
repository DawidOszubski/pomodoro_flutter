import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../../widgets/rounded_add_button_widget.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 24.0,
            right: 24.0,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RoundedAddButtonWidget(
                theme: theme,
                onTap: () {
                  print("XD");
                },
              ),
            ),
          ),
        ],
      ),
      screenTitle: "Testy",
      resizeToAvoidBottomInsets: false,
    );
  }
}
