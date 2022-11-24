import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/widgets/pop_up_widget.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';

class FlashCardScreen extends ConsumerStatefulWidget {
  const FlashCardScreen({Key? key}) : super(key: key);

  @override
  _FlashCardScreenState createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends ConsumerState<FlashCardScreen> {
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
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: PopUpWidget(
                        body: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 24.0,
                          ),
                          child: TextField(),
                        ),
                        mainColor: theme.mainColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      screenTitle: "Fiszki",
      resizeToAvoidBottomInsets: false,
    );
  }
}
