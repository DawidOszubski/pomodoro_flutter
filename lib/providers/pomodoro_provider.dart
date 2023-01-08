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

final updatePomodoroSetProvider = FutureProvider.autoDispose
    .family<void, PomodoroSetModel>((ref, pomodoroSet) async {
  return ref
      .watch(pomodoroServiceProvider)
      .updatePomodoroSet(pomodoroSet: pomodoroSet);
});

final deletePomodoroSetProvider = FutureProvider.autoDispose
    .family<void, PomodoroSetModel>((ref, pomodoroSet) async {
  ref.watch(pomodoroServiceProvider).deletePomodoroSet(pomodoroSet);
});

final timerRepeatCountProvider = StateProvider.autoDispose<int>((ref) => 1);

final pomodoroLearnPhaseProvider = StateProvider<List<int>>((ref) => []);
