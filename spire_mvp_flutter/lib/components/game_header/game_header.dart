import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/components/game_header/character_deck.dart';
import 'package:mathpunk_cardgame/components/game_header/character_gold.dart';
import 'package:mathpunk_cardgame/components/game_header/character_hitpoints.dart';
import 'package:mathpunk_cardgame/components/game_header/character_items.dart';
import 'package:mathpunk_cardgame/components/game_header/character_name.dart';
import 'package:mathpunk_cardgame/components/game_header/character_relics.dart';
import 'package:mathpunk_cardgame/components/game_header/header_map.dart';
import 'package:mathpunk_cardgame/components/game_header/header_pause.dart';

class GameHeader extends StatefulWidget {
  const GameHeader({Key? key}) : super(key: key);

  @override
  State<GameHeader> createState() => GameHeaderView();
}

class GameHeaderView extends State<GameHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 96,
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: const Color(0xFF222222),
          child: Stack(
            children: const [
              CharacterName(),
              CharacterHitpoints(),
              CharacterGold(),
              CharacterItems(),
              HeaderMap(),
              CharacterDeck(),
              HeaderPause(),
            ],
          ),
        ),
        const CharacterRelics(),
      ],
    );
  }
}
