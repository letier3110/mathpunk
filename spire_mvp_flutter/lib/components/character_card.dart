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
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    return GestureDetector(
        onTap: () => {gameState.selectPlayerCharacter(widget.character)},
        child: Card(
          child: Container(
            width: 120,
            height: 120,
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
