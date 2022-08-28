import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';

import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

import '../utils/font.util.dart';

class CharacterCard extends StatefulWidget {
  final PlayerCharacter character;
  final bool disabled;
  final bool visible;

  const CharacterCard(
      {required this.character,
      this.disabled = false,
      this.visible = true,
      Key? key})
      : super(key: key);

  @override
  State<CharacterCard> createState() => CharacterCardView();
}

class CharacterCardView extends State<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var isPcEqualsWidgetPc =
        gameState.playerCharacter?.name == widget.character.name;

    void onTapHandler() {
      if (widget.disabled) {
        return;
      }
      if (isPcEqualsWidgetPc) {
        gameState.deselectPlayerCharacter();
        return;
      }
      gameState.selectPlayerCharacter(widget.character);
      var player = Player();
      player.selectCharacter(widget.character);
    }

    return GestureDetector(
        onTap: onTapHandler,
        child: Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(8),
          decoration: isPcEqualsWidgetPc
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0,
                      spreadRadius: 0.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: Card(
            color: widget.disabled ? Colors.redAccent : Colors.amber,
            child: Center(child: characterNameToIcon(widget.character.name)),
          ),
        ));
  }
}

Widget characterNameToIcon(String name) {
  switch (name) {
    case 'Barbarian':
      return const Icon(
        Icons.favorite,
        color: Colors.pink,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    default:
      return const Icon(
        Icons.sailing,
        color: Colors.blueAccent,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
  }
}
