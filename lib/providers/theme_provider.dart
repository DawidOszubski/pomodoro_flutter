import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

final blueThemeProvider = StateProvider((ref) {
  return false;
});
final redThemeProvider = StateProvider((ref) {
  return true;
});
final brownThemeProvider = StateProvider((ref) {
  return false;
});

final isAluniaThemeProvider = StateProvider((ref) {
  return false;
});

final appThemeProvider = Provider((ref) {
  final isBlueTheme = ref.watch(blueThemeProvider);
  final isRedTheme = ref.watch(redThemeProvider);
  if (isBlueTheme) {
    return AppThemes.aluniaTheme;
  }
  if (isRedTheme) {
    return AppThemes.pomodoroTheme;
  } else {
    return AppThemes.mainTheme;
  }
});
