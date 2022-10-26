import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

final aluniaThemeProvider = StateProvider((ref) {
  return false;
});

final appThemeProvider = Provider((ref) {
  final isAluniaTheme = ref.watch(aluniaThemeProvider);
  if (isAluniaTheme) {
    return AppThemes.aluniaTheme;
  } else {
    return AppThemes.mainTheme;
  }
});
