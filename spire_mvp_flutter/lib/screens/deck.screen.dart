import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class DeckScreen extends ConsumerStatefulWidget {
  const DeckScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends ConsumerState<DeckScreen> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);

    void onCardTap(PlayableCard card) {
      // gameState.openLoreCard(card);
    }

    double width = MediaQuery.of(context).size.width;

    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/game_bg.png'), fit: BoxFit.fill),
          )),
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/deck_bg.png'), fit: BoxFit.fitWidth),
          ),
          child: Center(
            child: Stack(
              children: [
                SizedBox(
                    width: width * 0.855,
                    height: width * 0.4625,
                    child: Center(
                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //         color: Colors.deepOrangeAccent, width: 1)),
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 20 / 31,
                        children: gameState.inDeck
                            .map((e) => PlayableCardComponent(
                                card: e,
                                glow: false,
                                size: width * 0.855 / 4.2,
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
