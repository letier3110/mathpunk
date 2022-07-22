import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/components/playable_card/glow_effect.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class PlayableCardComponent extends StatefulWidget {
  final PlayableCard card;
  const PlayableCardComponent({required this.card, Key? key}) : super(key: key);

  @override
  State<PlayableCardComponent> createState() => PlayableCardComponentView();
}

var rng = Random();

class PlayableCardComponentView extends State<PlayableCardComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final cardId = Random().nextInt(1 << 32);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween<double>(begin: 4, end: 244).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    // controller.animateTo();
  }

  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    int playerMana = gameState.playerCharacter!.mana;

    void onEnterHandler(PointerEnterEvent p) {
      setState(() {
        controller.forward();
      });
    }

    void onExitHandler(PointerExitEvent p) {
      setState(() {
        controller.reverse();
      });
    }

    void onTapHandler() {
      if (widget.card.targetType == TargetEnum.singleTarget) {
        gameState.startSelecting(widget.card, cardId);
        return;
      } else if (widget.card.targetType == TargetEnum.playerTarget) {
        // TODO: implement some random fuzzy logic to select a target
        gameState.playTheCardOnPlayer(widget.card);
        return;
      } else if (widget.card.targetType == TargetEnum.randomTarget) {
        // TODO: implement some random fuzzy logic to select a target
        gameState.playTheCard(widget.card, gameState.currentRoom!.enemies);
        return;
      } else {
        gameState.playTheCard(widget.card, gameState.currentRoom!.enemies);
        return;
      }
    }

    return GestureDetector(
      onTap: onTapHandler,
      child: MouseRegion(
        onEnter: onEnterHandler,
        onExit: onExitHandler,
        child: Container(
          height: 308,
          width: 208,
          margin: EdgeInsets.fromLTRB(
              4,
              4,
              4,
              gameState.selectingTargetCardId == cardId
                  ? 244
                  : animation.value),
          child: Center(
            child: Stack(children: [
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(8),
                height: 304,
                width: 204,
              ),
              if (playerMana >= widget.card.mana &&
                  widget.card.isCardPlayable())
                const Center(
                  child: GlowEffect(
                      child: SizedBox(
                    height: 300,
                    width: 200,
                  )),
                ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // margin: const EdgeInsets.all(4),
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        width: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Text(
                                widget.card.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getFontSize(22)),
                              ),
                            ),
                            SizedBox(
                              height: 160,
                              child: Column(
                                children: [
                                  Text(
                                    widget.card.getCardDescription(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: getFontSize(16)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          // padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              widget.card.mana.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(22)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
