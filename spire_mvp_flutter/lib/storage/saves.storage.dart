import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/saves.controller.dart';
import 'package:spire_mvp_flutter/enums/screens.enum.dart';
import 'package:spire_mvp_flutter/interfaces/gamestate.interface.dart';

import '../controllers/navigation.controller.dart';

class SavesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getFile() async {
    final path = await _localPath;
    return File('$path/saves.bin');
  }

  Future<int> loadSaves(
      SavesController saves, NavigationController navigation) async {
    try {
      final saveFile = await getFile();

      // Read the file
      final contents = await saveFile.readAsString();

      saves.fromJson(jsonDecode(contents));

      saves.loading = false;

      saves.notifyListeners();

      navigation.changeScreen(ScreenEnum.mainMenu);

      return 1;
    } catch (e) {
      saves.loading = false;
      saves.notifyListeners();

      navigation.changeScreen(ScreenEnum.mainMenu);
      return 0;
    }
  }

  Future<int> writeSaves(SavesController saves) async {
    final save = await getFile();

    try {
      save.writeAsString(jsonEncode(saves.toJson()));
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
