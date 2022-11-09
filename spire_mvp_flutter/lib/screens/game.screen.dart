import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/game_header/game_header.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/screens/deck.screen.dart';
import 'package:mathpunk_cardgame/screens/lore.screen.dart';
import 'package:mathpunk_cardgame/screens/map.screen.dart';
import 'package:mathpunk_cardgame/screens/pause.screen.dart';
import 'package:mathpunk_cardgame/utils/room.util.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final gameMap =
        ref.watch(gamestateProvider.select((value) => value.gameMap));
    final currentRoom =
        ref.watch(gamestateProvider.select((value) => value.currentRoom));
    final inMap = ref.watch(gamestateProvider.select((value) => value.inMap));
    final loreCard =
        ref.watch(gamestateProvider.select((value) => value.loreCard));
    final inPause =
        ref.watch(gamestateProvider.select((value) => value.inPause));
    final inDeck =
        ref.watch(gamestateProvider.select((value) => value.inDeck)).isNotEmpty;

    return Scaffold(
      body: Stack(children: [
        if ((inMap == true || currentRoom == null) && inDeck == false)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: MapScreen(
              gameMap: gameMap,
            ),
          ),
        if (inMap == false && currentRoom != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: getRoomComponent(currentRoom),
          ),
        if (inDeck)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const DeckScreen(),
          ),
        if (loreCard != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const LoreScreen(),
          ),
        if (inPause)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const PauseScreen(),
          ),
        const GameHeader(),
      ]),
    );
  }
}
