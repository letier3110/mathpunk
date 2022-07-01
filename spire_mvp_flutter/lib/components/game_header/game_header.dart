import 'package:flutter/material.dart';

import 'package:spire_mvp_flutter/components/game_header/character_deck.dart';
import 'package:spire_mvp_flutter/components/game_header/character_gold.dart';
import 'package:spire_mvp_flutter/components/game_header/character_hitpoints.dart';
import 'package:spire_mvp_flutter/components/game_header/character_name.dart';
import 'package:spire_mvp_flutter/components/game_header/header_map.dart';
import 'package:spire_mvp_flutter/components/game_header/header_pause.dart';

class GameHeader extends StatefulWidget {
  const GameHeader({Key? key}) : super(key: key);

  @override
  State<GameHeader> createState() => GameHeaderView();
}

class GameHeaderView extends State<GameHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: EdgeInsets.zero,
      color: Colors.grey,
      child: Stack(
        children: const [
          CharacterName(),
          CharacterHitpoints(),
          CharacterGold(),
          HeaderMap(),
          CharacterDeck(),
          HeaderPause(),
        ],
      ),
    );

    // GestureDetector(
    //     onTap: () => {gameState.selectPlayerCharacter(widget.character)},
    //     child: Container(
    //       width: 120,
    //       height: 120,
    //       margin: const EdgeInsets.all(8),
    //       decoration: isPcEqualsWidgetPc
    //           ? const BoxDecoration(
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.green,
    //                   blurRadius: 20.0,
    //                   spreadRadius: 0.0,
    //                 )
    //               ],
    //             )
    //           : const BoxDecoration(),
    //       child: Card(
    //         color: widget.disabled ? Colors.red : Colors.amber,
    //         child: Center(
    //           child: Text(
    //             '${widget.character.name}.png',
    //             style: Theme.of(context).textTheme.bodyLarge,
    //             // color: Colors.amber
    //           ),
    //         ),
    //       ),
    //     ));
  }
}
