import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/theme_provider.dart';
import '../../../widgets/base_screen_widget.dart';
import '../../../widgets/rounded_add_button_widget.dart';

class ZadankaScreen extends ConsumerStatefulWidget {
  const ZadankaScreen({Key? key}) : super(key: key);

  @override
  _ZadankaScreenState createState() => _ZadankaScreenState();
}

class _ZadankaScreenState extends ConsumerState<ZadankaScreen> {
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
      screenTitle: "Zadanka",
      resizeToAvoidBottomInsets: false,
    );
  }
}
