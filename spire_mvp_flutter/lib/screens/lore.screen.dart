import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class LoreScreen extends StatefulWidget {
  const LoreScreen({Key? key}) : super(key: key);

  @override
  State<LoreScreen> createState() => _LoreScreenState();
}

class _LoreScreenState extends State<LoreScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    void onCardTap() {
      gameState.closeLoreCard();
    }

    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/lore_bg.png'), fit: BoxFit.fill),
          ),
          child: Center(
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(280, 20, 20, 140),
                    child: Container(
                        width: 330,
                        height: 440,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.deepOrangeAccent, width: 1)),
                        child: PlayableCardComponent(
                          card: gameState.loreCard!,
                          glow: false,
                          animate: false,
                          onTap: onCardTap,
                        ))),
              ],
            ),
          ))
    ]);
  }
}
