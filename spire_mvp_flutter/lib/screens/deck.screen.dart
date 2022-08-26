import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/components/playable_card/playable_card.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({Key? key}) : super(key: key);

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    void onCardTap(PlayableCard card) {
      gameState.openLoreCard(card);
    }

    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/deck_bg.png'), fit: BoxFit.fill),
          ),
          child: Center(
            child: Stack(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(92, 60, 82, 68),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.deepOrangeAccent, width: 1)),
                      child: GridView.count(
                        crossAxisCount: 4,
                        children: gameState.inDeck
                            .map((e) => PlayableCardComponent(
                                card: e,
                                glow: false,
                                animate: false,
                                onTap: () => {onCardTap(e)}))
                            .toList(),
                      ),
                    )),
              ],
            ),
          ))
    ]);
  }
}
