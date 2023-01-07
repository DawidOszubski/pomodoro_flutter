import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/learn_models/pomodoro_set_model.dart';
import '../services/pomodoro_service.dart';

final addPomodoroSetProvider = FutureProvider.autoDispose
    .family<void, PomodoroSetModel>((ref, pomodoroSet) async {
  return ref.watch(pomodoroServiceProvider).createPomodoroSet(pomodoroSet);
});

final getPomodoroSetsProvider =
    FutureProvider.autoDispose<List<PomodoroSetModel>?>((ref) async {
  return ref.watch(pomodoroServiceProvider).getAllPomodoroSets();
});
