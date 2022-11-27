import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/game_header/game_header.dart';
import 'package:mathpunk_cardgame/controllers/current_room.provider.dart';
import 'package:mathpunk_cardgame/controllers/gamemap.provider.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_deck.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_map.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_pause.provider.dart';
import 'package:mathpunk_cardgame/controllers/is_lore_card.provider.dart';
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
    final gameMap = ref.watch(gamemapProvider);
    final currentRoom = ref.watch(currentRoomProvider);
    final inMap = ref.watch(inMapProvider);
    final loreCard = ref.watch(isLoreCardProvider);
    final inPause = ref.watch(inPauseProvider);
    final inDeck =
        ref.watch(inDeckProvider.select((value) => value.isNotEmpty));

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
