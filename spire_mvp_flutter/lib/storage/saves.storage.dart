import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class SavesStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getFile() async {
    final path = await _localPath;
    return File('$path/saves.bin');
  }

  Future<int> loadSaves(
      SavesNotifier saves, NavigationNotifier navigation) async {
    try {
      final saveFile = await _getFile();
      final contents = await saveFile.readAsString();

      dynamic saveSlots = jsonDecode(contents);

      saves.fromJson(saveSlots);

      saves.setLoading(false);

      // if save exist

      navigation.changeScreen(ScreenEnum.mainMenu);

      return 1;
    } catch (e) {
      // if save not exist
      saves.setLoading(false);
      navigation.changeScreen(ScreenEnum.mainMenu);
      return 0;
    }
  }

  Future<int> writeSaves(SavesNotifier saves) async {
    final save = await _getFile();

    try {
      save.writeAsString(jsonEncode(saves.toJson()));
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
