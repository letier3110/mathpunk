import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/interfaces/gamestate.interface.dart';

class GameStateStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.bin');
  }

  Future<int> loadProfile(GamestateController gameState, int profile) async {
    try {
      // final file = await _profileFile;
      var profileSaveName = 'save1';
      if (profile == 2) {
        profileSaveName = 'save2';
      } else if (profile == 3) {
        profileSaveName = 'save3';
      }
      final saveFile = await getFile(profileSaveName);

      // Read the file
      final contents = await saveFile.readAsString();

      dynamic jsonState = jsonDecode(contents);

      GameStateInterface state = GameStateInterface.fromJson(jsonState);

      gameState.fromJson(state);

      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<List<String>> readProfiles(
      GamestateController gameState, int profile) async {
    try {
      final save1 = await getFile('save1');
      final save2 = await getFile('save2');
      final save3 = await getFile('save3');

      final contents1 = await save1.readAsString();
      final contents2 = await save2.readAsString();
      final contents3 = await save3.readAsString();

      GameStateInterface savedData1 =
          GameStateInterface.fromJson(jsonDecode(contents1));
      GameStateInterface savedData2 =
          GameStateInterface.fromJson(jsonDecode(contents2));
      GameStateInterface savedData3 =
          GameStateInterface.fromJson(jsonDecode(contents3));

      return [
        savedData1.playerName,
        savedData2.playerName,
        savedData3.playerName
      ];
    } catch (e) {
      return [];
    }
  }

  Future<int> writeState(GamestateController gameState, int profile) async {
    var profileSaveName = 'save1';
    if (profile == 2) {
      profileSaveName = 'save2';
    } else if (profile == 3) {
      profileSaveName = 'save3';
    }
    final save = await getFile(profileSaveName);

    try {
      final jsonState = gameState.toJson();
      final contents = jsonEncode(jsonState);
      await save.writeAsString(contents);

      return 1;
    } catch (e) {
      return 0;
    }
  }
}
