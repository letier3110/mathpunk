import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class CharacterCard extends ConsumerStatefulWidget {
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
  ConsumerState<CharacterCard> createState() => CharacterCardView();
}

class CharacterCardView extends ConsumerState<CharacterCard> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);
    // final gameStateNotifier = ref.read(gamestateProvider.notifier);

    var isPcEqualsWidgetPc =
        gameState.state.playerCharacter?.name == widget.character.name;

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
    case 'Priest':
      return const Icon(
        Icons.abc_sharp,
        color: Colors.green,
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
