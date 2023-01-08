import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';

class PlannerScreen extends ConsumerStatefulWidget {
  const PlannerScreen({Key? key}) : super(key: key);

  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends ConsumerState<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
        mainColor: theme.mainColor,
        screenTitle: "planner.title".tr(),
        body: Container());
  }
}
