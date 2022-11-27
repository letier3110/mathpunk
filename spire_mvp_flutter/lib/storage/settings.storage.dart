import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:mathpunk_cardgame/controllers/settings.provider.dart';

class SettingsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _getFile() async {
    final path = await _localPath;
    return File('$path/settings.bin');
  }

  Future<int> loadSettings(SettingsNotifier settingsState) async {
    try {
      final saveFile = await _getFile();

      final contents = await saveFile.readAsString();

      dynamic jsonState = jsonDecode(contents);

      SettingsNotifierInterface state =
          SettingsNotifierInterface.fromJson(jsonState);

      settingsState.fromJson(state);

      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> writeState(SettingsNotifier settingsNotifier) async {
    final save = await _getFile();

    try {
      final jsonState = settingsNotifier.toJson();
      final contents = jsonEncode(jsonState);
      await save.writeAsString(contents);

      return 1;
    } catch (e) {
      return 0;
    }
  }
}
