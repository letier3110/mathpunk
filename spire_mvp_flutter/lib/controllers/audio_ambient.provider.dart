// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/controllers/settings.provider.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class AudioAmbientInterface {
  AudioAmbientInterface(
      // {required this.currentScreen, this.gameMode, this.audioAmbientVolume}
      );
  // ScreenEnum currentScreen;
  // double? audioAmbientVolume = 1;
  // GameTypeEnum? gameMode;
}

final audioAmbientProvider =
    StateNotifierProvider<AudioAmbientNotifier, AudioAmbientInterface>((ref) {
  // final currentScreen = ref.watch(navigationProvider);
  // final gameMode =
  //     ref.read(gamestateProvider.select((value) => value.gameMode));
  // final audioAmbientVolume =
  //     ref.watch(settingsProvider.select((value) => value.audioAmbientVolume));
  return AudioAmbientNotifier();
});

class AudioAmbientNotifier extends StateNotifier<AudioAmbientInterface> {
  AudioAmbientNotifier() : super(AudioAmbientInterface());
}
