// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class AudioAmbientInterface {
  AudioAmbientInterface({required this.currentScreen, this.gameMode});
  ScreenEnum currentScreen;
  GameTypeEnum? gameMode;
}

final audioAmbientProvider =
    StateNotifierProvider<AudioAmbientNotifier, AudioAmbientInterface>((ref) {
  final currentScreen = ref.watch(navigationProvider);
  final gameMode =
      ref.read(gamestateProvider.select((value) => value.gameMode));
  return AudioAmbientNotifier(currentScreen: currentScreen, gameMode: gameMode);
});

class AudioAmbientNotifier extends StateNotifier<AudioAmbientInterface> {
  // final player = AudioPlayer();

  // void playMenuTheme() async {
  //   await player.setSource(AssetSource('ambient/main_menu_2.mp3'));
  //   await player.setReleaseMode(ReleaseMode.loop);
  //   await player.resume();
  // }

  // void stopMenuTheme() async {
  //   await player.setReleaseMode(ReleaseMode.stop);
  //   await player.stop();
  // }

  AudioAmbientNotifier(
      {required ScreenEnum currentScreen, GameTypeEnum? gameMode})
      : super(AudioAmbientInterface(
            currentScreen: currentScreen, gameMode: gameMode));
}
