import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/models/flashcards_model/flashcard_item_model.dart';

import '../models/flashcards_model/flash_card_model.dart';
import '../services/flashcard_service.dart';

final addFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).createFlashcardSet(flashCardModel);
});

final getFlashcardSetsProvider =
    FutureProvider.autoDispose<List<FlashCardModel>?>((ref) async {
  return ref.watch(flashcardServiceProvider).getAllFlashcardSets();
});

final deleteFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).deleteFlashcardSet(flashCardModel);
});

final addCountFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).updateFlashcardSet(flashCardModel);
});

final changeNameFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref
      .watch(flashcardServiceProvider)
      .changeFlashcardSetName(flashcard: flashCardModel);
});

final addNewFlashcardItemProvider = FutureProvider.autoDispose
    .family<int, FlashcardItemModel>((ref, flashCardItemModel) async {
  return ref
      .watch(flashcardServiceProvider)
      .createFlashcard(flashCardItemModel: flashCardItemModel);
});

final getFlashcardsProvider = FutureProvider.autoDispose
    .family<List<FlashcardItemModel>?, int>((ref, flashcardSetId) async {
  return ref
      .watch(flashcardServiceProvider)
      .getAllFlashcardsInSet(flashcardSetId: flashcardSetId);
});
