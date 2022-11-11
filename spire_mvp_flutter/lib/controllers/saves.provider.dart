import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/storage/gamestate.storage.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/storage/saves.storage.dart';

GameStateStorage gameStorage = GameStateStorage();

final savesProvider =
    StateNotifierProvider<SavesNotifier, SavesInterface>((ref) {
  return SavesNotifier();
});

class SavesInterface {
  SavesInterface({
    this.currentSaveSlot,
    this.loading = true,
    this.saveSlots = const [],
  });
  int? currentSaveSlot;
  bool loading = true;

  List<String> saveSlots = [];

  final SavesStorage _storage = SavesStorage();
}

class SavesNotifier extends StateNotifier<SavesInterface> {
  SavesNotifier() : super(SavesInterface());

  List<String> showSavedGames() {
    return state.saveSlots;
  }

  void selectSaveSlot(int slot) {
    // state.currentSaveSlot = slot;
    state = SavesInterface(
        currentSaveSlot: slot,
        saveSlots: state.saveSlots,
        loading: state.loading);
  }

  void setLoading(bool loading) {
    // state.loading = loading;
    state = SavesInterface(
        currentSaveSlot: state.currentSaveSlot,
        saveSlots: state.saveSlots,
        loading: loading);
  }

  void loadSavesMetadata(NavigationNotifier navigation) {
    state._storage.loadSaves(this, navigation);
  }

  void setSaveSlots(List<String> saveSlots) {
    // state.saveSlots = saveSlots;
    state = SavesInterface(
        currentSaveSlot: state.currentSaveSlot,
        saveSlots: saveSlots,
        loading: state.loading);
  }

  void createNewSlot(String slot) {
    state = SavesInterface(
        currentSaveSlot: state.saveSlots.length,
        saveSlots: [...state.saveSlots, slot],
        loading: state.loading);

    state._storage.writeSaves(this);
  }

  String? getSave() {
    if (state.currentSaveSlot == null) return null;
    return state.saveSlots.elementAt(state.currentSaveSlot!);
  }

  void loadGame(GamestateNotifier gameState) {
    gameStorage.loadProfile(gameState, state.currentSaveSlot!);
  }

  void saveGame(GamestateNotifier gameState) {
    gameStorage.writeState(gameState, state.currentSaveSlot!);
  }

  SavesNotifier fromJson(dynamic json) {
    state.currentSaveSlot = int.parse(json["currentSaveSlot"]);
    state.saveSlots =
        (json['saveSlots'] as List).map((e) => e.toString()).toList();
    return this;
  }

  Map toJson() => {
        'currentSaveSlot': state.currentSaveSlot,
        'saveSlots': state.saveSlots.map((e) => e.toString()).toList()
      };
}
