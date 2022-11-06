import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

class LearnScreenListItemWidget extends ConsumerStatefulWidget {
  const LearnScreenListItemWidget({
    Key? key,
    required this.title,
    required this.nextScreen,
  }) : super(key: key);

  final String title;
  final Widget nextScreen;

  @override
  _LearnScreenListItemWidgetState createState() =>
      _LearnScreenListItemWidgetState();
}

class _LearnScreenListItemWidgetState
    extends ConsumerState<LearnScreenListItemWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(
                milliseconds: 350,
              ),
              child: widget.nextScreen),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4.0,
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            color: theme.mainColor,
            size: 25,
          ),
          title: Text(widget.title),
        ),
      ),
    );
  }
}
