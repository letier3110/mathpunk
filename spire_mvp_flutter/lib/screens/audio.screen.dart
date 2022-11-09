import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen> {
  final player = AudioPlayer();

  void setSourceBattle() async {
    await player.setSource(AssetSource('ambient/battle_4.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  void setSourceMainMenu() async {
    await player.setSource(AssetSource('ambient/main_menu_2.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  void playMenuTheme() async {
    await player.stop();
    setSourceMainMenu();
    await player.resume();
  }

  void playBattleTheme() async {
    await player.stop();
    setSourceBattle();
    await player.resume();
  }

  void stopMenuTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
  }

  // @override
  // void didUpdateWidget(covariant AudioScreen widget) {
  //   final currentScreen = ref.read(navigationProvider);
  //   // final gameMode =
  //   //     ref.read(gamestateProvider.select((value) => value.gameMode));

  //   if (currentScreen == ScreenEnum.mainMenu ||
  //       currentScreen == ScreenEnum.modeSelect) {
  //     playMenuTheme();
  //   }
  //   if (currentScreen == ScreenEnum.characterSelect) {
  //     playBattleTheme();
  //   }
  //   super.didUpdateWidget(widget);
  // }

  // @override
  // void didUpdateWidget(covariant AudioScreen oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stopMenuTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(navigationProvider);

    if (currentScreen == ScreenEnum.mainMenu ||
        currentScreen == ScreenEnum.modeSelect) {
      playMenuTheme();
    }
    // final gameMode =
    //     ref.read(gamestateProvider.select((value) => value.gameMode));
    return const SizedBox.shrink();
  }
}
