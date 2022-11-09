import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class HandView extends ConsumerStatefulWidget {
  const HandView({Key? key}) : super(key: key);

  @override
  ConsumerState<HandView> createState() => HandViewView();
}

class HandViewView extends ConsumerState<HandView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);

    List<PlayableCard> hand = gameState.playerCharacter!.deck.hand;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Positioned(
      bottom: -(height * 9 / 35),
      left: width / 6,
      right: width / 6,
      child: Stack(children: [
        Container(
            padding: const EdgeInsets.all(8),
            // height: width * 1 / 3,
            // height: 600,
            height: height * 4 / 7,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: hand
                  .map((e) => PlayableCardComponent(
                        card: e,
                        size: height * 1.5 / 7,
                      ))
                  .toList(),
            )),
      ]),
    );
  }
}
