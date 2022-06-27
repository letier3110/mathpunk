import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

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

    return GestureDetector(
        onTap: () => {gameState.selectPlayerCharacter(widget.character)},
        child: Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.all(8),
          decoration: isPcEqualsWidgetPc
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 0.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: Card(
            color: widget.disabled ? Colors.red : Colors.amber,
            child: Center(
              child: Text(
                '${widget.character.name}.png',
                style: Theme.of(context).textTheme.bodyLarge,
                // color: Colors.amber
              ),
            ),
          ),
        ));
  }
}
