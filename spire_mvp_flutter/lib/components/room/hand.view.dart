import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/components/playable_card/playable_card.view.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class HandView extends StatefulWidget {
  const HandView({Key? key}) : super(key: key);

  @override
  State<HandView> createState() => HandViewView();
}

class HandViewView extends State<HandView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    List<PlayableCard> hand = gameState.playerCharacter!.deck.hand;
    var handLength = hand.length;

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      bottom: -160,
      left: 220,
      right: 220,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
              padding: const EdgeInsets.all(8),
              height: 400,
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    hand.map((e) => PlayableCardComponent(card: e)).toList(),
              )),
          // Positioned(
          //     bottom: -12,
          //     right: -12,
          //     child: SizedBox(
          //       width: 40,
          //       height: 50,
          //       child: Center(
          //         child: Text(
          //           handLength.toString(),
          //           textAlign: TextAlign.center,
          //           style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 22,
          //               fontWeight: FontWeight.w600),
          //         ),
          //       ),
          //     ))
        ]),
      ),
    );
  }
}
