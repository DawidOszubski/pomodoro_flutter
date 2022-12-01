import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/flash_card_model.dart';
import 'package:pomodoro_flutter/services/database_helper.dart';

final addFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).addFlashcard(flashCardModel);
});

final getFlashcardsProvider =
    FutureProvider.autoDispose<List<FlashCardModel>?>((ref) async {
  return ref.watch(flashcardServiceProvider).getAllFlashCards();
});

final deleteFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).deleteFlashCard(flashCardModel);
});
