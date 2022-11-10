import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/event_room/mind_bloom.event.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

enum AudioState { mainMenu, battle, map, mindBloom, trader }

class _AudioScreenState extends ConsumerState<AudioScreen> {
  final player = AudioPlayer();
  AudioState? audioState;

  void setSourceBattle() async {
    await player.setSource(AssetSource('ambient/battle_4.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  void setSourceMainMenu() async {
    await player.setSource(AssetSource('ambient/main_menu_2.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  void setSourceMap() async {
    await player.setSource(AssetSource('ambient/map_3.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
  }

  void playMenuTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
    await player.setSource(AssetSource('ambient/main_menu_2.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void playBattleTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
    await player.setSource(AssetSource('ambient/battle_4.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void playMapTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
    await player.setSource(AssetSource('ambient/map_3.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void playMindBloomTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
    await player.setSource(AssetSource('ambient/event.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void playTraderTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
    await player.setSource(AssetSource('ambient/trade.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void stopPlayingTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stopPlayingTheme();
    super.dispose();
  }

  void setMainMenu() {
    setState(() {
      if (audioState != AudioState.mainMenu) {
        audioState = AudioState.mainMenu;
        playMenuTheme();
      }
    });
  }

  void setBattle() {
    setState(() {
      if (audioState != AudioState.battle) {
        audioState = AudioState.battle;
        playBattleTheme();
      }
    });
  }

  void setMap() {
    setState(() {
      if (audioState != AudioState.map) {
        audioState = AudioState.map;
        playMapTheme();
      }
    });
  }

  void setMindBloom() {
    setState(() {
      if (audioState != AudioState.mindBloom) {
        audioState = AudioState.mindBloom;
        playMindBloomTheme();
      }
    });
  }

  void setTrader() {
    setState(() {
      if (audioState != AudioState.trader) {
        audioState = AudioState.trader;
        playTraderTheme();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentScreen = ref.watch(navigationProvider);
    final inMap = ref.watch(gamestateProvider.select((value) => value.inMap));

    final currentRoom =
        ref.watch(gamestateProvider.select((value) => value.currentRoom));

    if (currentScreen == ScreenEnum.mainMenu ||
        currentScreen == ScreenEnum.modeSelect) {
      setMainMenu();
    }
    if (currentScreen == ScreenEnum.game &&
        ((currentRoom == null) ||
            (inMap &&
                currentRoom.runtimeType == EnemyRoom &&
                currentRoom.enemies.isEmpty))) {
      setMap();
    }
    if (currentScreen == ScreenEnum.game &&
        currentRoom != null &&
        currentRoom.runtimeType == EnemyRoom &&
        currentRoom.enemies.isNotEmpty) {
      setBattle();
    }
    if (currentScreen == ScreenEnum.game &&
        currentRoom != null &&
        currentRoom.runtimeType == TradeRoom) {
      setTrader();
    }
    if (currentScreen == ScreenEnum.game &&
        currentRoom != null &&
        currentRoom.runtimeType == MindBloomEventRoom) {
      setMindBloom();
    }
    return const SizedBox.shrink();
  }
}
