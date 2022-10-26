import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/learn/pomodoro/pomodoro_screen.dart';

class LearnScreenListItemWidget extends ConsumerWidget {
  const LearnScreenListItemWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 250),
              child: const PomodoroScreen(),
            ),
          );
        },
        child: Card(
          elevation: 2,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: theme.mainColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
