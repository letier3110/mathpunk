import 'package:flutter/material.dart';

import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/components/consumable.view.dart';
import 'package:spire_mvp_flutter/components/playable_card/playable_card.view.dart';
import 'package:spire_mvp_flutter/components/relic.view.dart';

// View of rewards
class TraderView extends StatefulWidget {
  final TradeRoom room;
  const TraderView({required this.room, Key? key}) : super(key: key);

  @override
  State<TraderView> createState() => TraderViewView();
}

class TraderViewView extends State<TraderView> {
  @override
  Widget build(BuildContext context) {
    // GamestateController gameState =
    //     Provider.of<GamestateController>(context, listen: false);

    // void onTapHandler() {
    //   // gameState.nextTurn();
    // }
    return Center(
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      children: widget.room.cards
                          .map((card) => PlayableCardComponent(
                                card: card,
                                glow: false,
                                animate: false,
                              ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: widget.room.relics
                          .map((relic) => RelicView(relic: relic))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: widget.room.items
                          .map((item) => ConsumableView(item: item))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
