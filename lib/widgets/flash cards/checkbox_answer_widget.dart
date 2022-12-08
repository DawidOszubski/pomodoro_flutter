import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';

class CheckboxAnswerWidget extends ConsumerStatefulWidget {
  const CheckboxAnswerWidget({Key? key}) : super(key: key);

  @override
  _CheckboxAnswerWidgetState createState() => _CheckboxAnswerWidgetState();
}

class _CheckboxAnswerWidgetState extends ConsumerState<CheckboxAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // width: 24,
          // height: 24,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: theme.mainColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              Icons.check,
              color: theme.mainColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
