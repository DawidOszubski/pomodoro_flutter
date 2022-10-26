import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_assets.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/learn_screen/learn_screen_list_item_widget.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text("Czas na naukę"),
        centerTitle: true,
        foregroundColor: theme.backgroundColor,
        backgroundColor: theme.mainColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LearnScreenListItemWidget(title: "Pomodoro"),
                LearnScreenListItemWidget(title: "Test"),
                LearnScreenListItemWidget(title: "Inne"),
              ],
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: Image.asset(
                AppAssets.aluniaHmmImage,
                scale: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
