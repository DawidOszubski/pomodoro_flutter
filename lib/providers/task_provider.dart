import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/planner_models/task_model.dart';
import 'package:pomodoro_flutter/services/planner_service.dart';

final addTaskProvider =
    FutureProvider.autoDispose.family<void, TaskModel>((ref, taskModel) async {
  return ref.watch(plannerServiceProvider).createTask(taskModel);
});

final getTasksProvider = FutureProvider.autoDispose
    .family<List<TaskModel>?, String?>((ref, date) async {
  return ref.watch(plannerServiceProvider).getTasks(date: date);
});
