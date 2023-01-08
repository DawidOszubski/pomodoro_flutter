import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../providers/theme_provider.dart';

class NotepadScreen extends ConsumerStatefulWidget {
  const NotepadScreen({Key? key}) : super(key: key);

  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends ConsumerState<NotepadScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
        mainColor: theme.mainColor,
        screenTitle: "notepad.title".tr(),
        body: Container());
  }
}
