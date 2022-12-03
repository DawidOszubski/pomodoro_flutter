import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/flashcards_model/flash_card_model.dart';
import '../services/flashcard_service.dart';

final addFlashcardProvider = FutureProvider.autoDispose
    .family<int, FlashCardModel>((ref, flashCardModel) async {
  return ref.watch(flashcardServiceProvider).createFlashcardSet(flashCardModel);
});

final getFlashcardsProvider =
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
