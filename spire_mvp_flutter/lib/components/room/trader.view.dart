import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/anger_card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/classes/sellable.dart';
import 'package:mathpunk_cardgame/components/consumable.view.dart';
import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/components/relic.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

const double cardHeight = 300;

// View of rewards
class TraderView extends ConsumerStatefulWidget {
  final TradeRoom room;
  const TraderView({required this.room, Key? key}) : super(key: key);

  @override
  ConsumerState<TraderView> createState() => TraderViewView();
}

class TraderViewView extends ConsumerState<TraderView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.read(gamestateProvider.notifier);

    void onTapHandler(Sellable sellable) {
      gameState.buyItem(sellable);
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/game_bg.png'), fit: BoxFit.fill),
      ),
      child: Row(
        children: [
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 10,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  width * 0.06, width * 0.036, width * 0.06, width * 0.036),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/deck_bg.png'),
                    fit: BoxFit.fitWidth),
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[0].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[0].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[0])},
                                ),
                              ),
                            if (widget.room.cards[0].inStock)
                              widget.room.cards[0].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[1].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[1].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[1])},
                                ),
                              ),
                            if (widget.room.cards[1].inStock)
                              widget.room.cards[1].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[2].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[2].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[2])},
                                ),
                              ),
                            if (widget.room.cards[2].inStock)
                              widget.room.cards[2].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[3].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[3].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[3])},
                                ),
                              ),
                            if (widget.room.cards[3].inStock)
                              widget.room.cards[3].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[4].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[4].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[4])},
                                ),
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
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[5].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[5].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[5])},
                                ),
                              ),
                            if (widget.room.cards[5].inStock)
                              widget.room.cards[5].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            if (widget.room.cards[6].inStock)
                              SizedBox(
                                height: height * 0.44,
                                child: PlayableCardComponent(
                                  size: width * 0.154,
                                  card: widget.room.cards[6].card,
                                  glow: false,
                                  animate: false,
                                  onTap: () =>
                                      {onTapHandler(widget.room.cards[6])},
                                ),
                              ),
                            if (widget.room.cards[6].inStock)
                              widget.room.cards[6].getCostDescription()
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.300,
                        height: cardHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: widget.room.relics
                                  .map((sellable) => SizedBox(
                                      width: width * 0.09,
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF222222),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
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
                                        ),
                                      )))
                                  .toList(),
                            ),
                            Row(
                              children: widget.room.items
                                  .map((sellable) => SizedBox(
                                      width: width * 0.09,
                                      child: Container(
                                        margin: const EdgeInsets.all(4),
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF222222),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
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
                                        ),
                                      )))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),

                      // Removal
                      SizedBox(
                        height: height * 0.5,
                        width: width * 0.155,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.44,
                              child: PlayableCardComponent(
                                size: width * 0.154,
                                card: AngerCard(),
                                glow: false,
                                animate: false,
                                disabled: true,
                                onTap: () => {},
                              ),
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
        ],
      ),
    );
  }
}
