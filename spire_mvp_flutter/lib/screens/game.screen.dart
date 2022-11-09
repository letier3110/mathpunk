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
    final gameState = ref.watch(gamestateProvider);

    bool inDeck = gameState.inDeck.isNotEmpty;

    return Scaffold(
      body: Stack(children: [
        if ((gameState.inMap == true || gameState.currentRoom == null) &&
            gameState.inDeck.isEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: MapScreen(
              gameMap: gameState.gameMap,
            ),
          ),
        if (gameState.inMap == false && gameState.currentRoom != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: getRoomComponent(gameState.currentRoom!),
          ),
        if (inDeck)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const DeckScreen(),
          ),
        if (gameState.loreCard != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const LoreScreen(),
          ),
        if (gameState.inPause)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 96, 0, 0),
            child: const PauseScreen(),
          ),
        const GameHeader(),
      ]),
    );
  }
}
