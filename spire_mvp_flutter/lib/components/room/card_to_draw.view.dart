import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

import '../playable_card/playable_card.view.dart';

class CardToDraw extends StatefulWidget {
  final List<PlayableCard> cards;
  final PlayableCard currentCard;
  const CardToDraw({Key? key, required this.cards, required this.currentCard})
      : super(key: key);

  @override
  State<CardToDraw> createState() => CardToDrawView();
}

class CardToDrawView extends State<CardToDraw> {
  List<PlayableCard> choice = [];

  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onSubmitTapHandler() {
      gameState.setSelectedCards(choice);
      gameState.playTheCard(widget.currentCard, []);
    }

    void onTapHandler(PlayableCard tapCard) {
      setState(() {
        if (choice.contains(tapCard)) {
          choice.remove(tapCard);
        } else if (choice.length < widget.currentCard.getMaxSelectableCards()) {
          choice.add(tapCard);
        }
      });
    }

    return Container(
      color: Colors.black38,
      child: Positioned(
        top: 0,
        left: 200,
        right: 200,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 400,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.cards
                  .map((e) => GestureDetector(
                        onTap: () {
                          onTapHandler(e);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: IgnorePointer(
                          ignoring: true,
                          ignoringSemantics: true,
                          child: PlayableCardComponent(
                            card: e,
                            animate: false,
                            glow: choice.contains(e),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Positioned(
              bottom: 300,
              child: Center(
                child: GestureDetector(
                  onTap: onSubmitTapHandler,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Text(
                      'Confirm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getFontSize(22),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
