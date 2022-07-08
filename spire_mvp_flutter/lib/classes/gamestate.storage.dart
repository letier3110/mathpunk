import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/interfaces/gamestate.interface.dart';

class GameStateStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Future<File> get _profileFile async {
  //   final path = await _localPath;
  //   return File('$path/mathpunk/profiles.bin');
  // }

  Future<File> getFile(String fileName) async {
    final path = await _localPath;
    return File('$path/mathpunk/$fileName.bin');
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
      final contents = await saveFile.readAsBytes();

      gameState.parseFromUInt8Array(contents);

      return 1;
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<List<String>> readProfiles(
      GamestateController gameState, int profile) async {
    try {
      final save1 = await getFile('save1');
      final save2 = await getFile('save2');
      final save3 = await getFile('save3');

      final contents1 = await save1.readAsBytes();
      final contents2 = await save2.readAsBytes();
      final contents3 = await save3.readAsBytes();

      GameStateInterface savedData1 =
          GameStateInterface.parseFromUInt8Array(contents1);
      GameStateInterface savedData2 =
          GameStateInterface.parseFromUInt8Array(contents2);
      GameStateInterface savedData3 =
          GameStateInterface.parseFromUInt8Array(contents3);

      // gameState.parse(contents1);
      return [
        savedData1.player.name,
        savedData2.player.name,
        savedData3.player.name
      ];
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  Future<File> writeState(
      GamestateController gameState, String saveName) async {
    final save = await getFile(saveName);

    // Write the file
    return save.writeAsBytes(gameState.toUInt8Array());
  }
}
