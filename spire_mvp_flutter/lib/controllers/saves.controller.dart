import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/storage/gamestate.storage.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/storage/saves.storage.dart';

GameStateStorage gameStorage = GameStateStorage();

class SavesController extends ChangeNotifier {
  int? currentSaveSlot;
  bool loading = true;

  List<String> saveSlots = [];

  final SavesStorage _storage = SavesStorage();

  List<String> showSavedGames() {
    return saveSlots;
  }

  void selectSaveSlot(int slot) {
    currentSaveSlot = slot;

    notifyListeners();
  }

  void loadSavesMetadata(NavigationController navigation) {
    _storage.loadSaves(this, navigation);
  }

  void setSaveSlots(List<String> saveSlots) {
    this.saveSlots = saveSlots;

    notifyListeners();
  }

  void createNewSlot(String slot) {
    currentSaveSlot = saveSlots.length;
    saveSlots.add(slot);

    _storage.writeSaves(this);

    notifyListeners();
  }

  String? getSave() {
    if (currentSaveSlot == null) return null;
    return saveSlots.elementAt(currentSaveSlot!);
  }

  void loadGame(GamestateController gameState) {
    gameStorage.loadProfile(gameState, currentSaveSlot!);
    gameStorage.readProfiles(gameState, currentSaveSlot!);
  }

  void fromJson(dynamic json) {
    currentSaveSlot = json["currentSaveSlot"] as int;
    saveSlots = (json['saveSlots'] as List).map((e) => e.toString()).toList();
    notifyListeners();
  }

  Map toJson() => {
        'currentSaveSlot': currentSaveSlot,
        'saveSlots': saveSlots.map((e) => e.toString()).toList()
      };
}
