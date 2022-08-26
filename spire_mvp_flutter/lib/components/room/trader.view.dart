import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/anger.card.dart';

import 'package:spire_mvp_flutter/classes/room/trade_room.dart';
import 'package:spire_mvp_flutter/classes/sellable.dart';
import 'package:spire_mvp_flutter/components/consumable.view.dart';
import 'package:spire_mvp_flutter/components/playable_card/playable_card.view.dart';
import 'package:spire_mvp_flutter/components/relic.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

const double cardHeight = 225;
const double cardWidth = 150;

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
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onTapHandler(Sellable sellable) {
      gameState.buyItem(sellable);
    }

    return Center(
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[0].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[0].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[0])},
                              ),
                            if (widget.room.cards[0].inStock)
                              widget.room.cards[0].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[1].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[1].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[1])},
                              ),
                            if (widget.room.cards[1].inStock)
                              widget.room.cards[1].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[2].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[2].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[2])},
                              ),
                            if (widget.room.cards[2].inStock)
                              widget.room.cards[2].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[3].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[3].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[3])},
                              ),
                            if (widget.room.cards[3].inStock)
                              widget.room.cards[3].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[4].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[4].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[4])},
                              ),
                            if (widget.room.cards[4].inStock)
                              widget.room.cards[4].getCostDescription()
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[5].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[5].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[5])},
                              ),
                            if (widget.room.cards[5].inStock)
                              widget.room.cards[5].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            if (widget.room.cards[6].inStock)
                              PlayableCardComponent(
                                size: cardWidth,
                                card: widget.room.cards[6].card,
                                glow: false,
                                animate: false,
                                onTap: () =>
                                    {onTapHandler(widget.room.cards[6])},
                              ),
                            if (widget.room.cards[6].inStock)
                              widget.room.cards[6].getCostDescription()
                          ],
                        ),
                      ),
                      Container(
                        width: 412,
                        height: cardHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: widget.room.relics
                                  .map((sellable) => Container(
                                      width: 130,
                                      child: Column(
                                        children: [
                                          if (sellable.inStock)
                                            RelicView(
                                              relic: sellable.relic,
                                              onTap: () =>
                                                  {onTapHandler(sellable)},
                                            ),
                                          if (sellable.inStock)
                                            sellable.getCostDescription()
                                        ],
                                      )))
                                  .toList(),
                            ),
                            Row(
                              children: widget.room.items
                                  .map((sellable) => Container(
                                      width: 130,
                                      child: Column(
                                        children: [
                                          if (sellable.inStock)
                                            ConsumableView(
                                                item: sellable.item,
                                                onTap: () =>
                                                    {onTapHandler(sellable)}),
                                          if (sellable.inStock)
                                            sellable.getCostDescription()
                                        ],
                                      )))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      // Removal
                      SizedBox(
                        height: cardHeight + 40,
                        width: cardWidth,
                        child: Column(
                          children: [
                            PlayableCardComponent(
                              size: cardWidth,
                              card: AngerCard(),
                              glow: false,
                              animate: false,
                              disabled: true,
                              onTap: () => {},
                            ),
                            widget.room.removal.getCostDescription()
                          ],
                        ),
                      ),
                    ],
                  )
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
