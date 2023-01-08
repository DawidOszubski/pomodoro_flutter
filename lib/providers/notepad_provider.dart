import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';
import 'package:pomodoro_flutter/services/notepad_service.dart';

final addNotepadProvider = FutureProvider.autoDispose
    .family<void, NotepadModel>((ref, notepadModel) async {
  return ref.watch(notepadServiceProvider).createNote(notepadModel);
});
