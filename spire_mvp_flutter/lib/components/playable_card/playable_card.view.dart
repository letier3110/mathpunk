import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/components/playable_card/glow_effect.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

const double defaultHeight = 300;
const double defaultWidth = 200;

const wavecolor = Color.fromARGB(119, 179, 223, 46);

class PlayableCardComponent extends StatefulWidget {
  final PlayableCard card;
  final bool glow;
  final bool animate;
  final Function? onTap;
  final double? size;
  final bool disabled;
  const PlayableCardComponent(
      {required this.card,
      this.glow = true,
      this.animate = true,
      this.onTap,
      this.size = defaultWidth,
      this.disabled = false,
      Key? key})
      : super(key: key);

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
    animation = Tween<double>(begin: 4, end: (widget.size ?? defaultWidth) * 1)
        .animate(controller)
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
      if (widget.animate) {
        setState(() {
          controller.forward();
        });
      }
    }

    void onExitHandler(PointerExitEvent p) {
      if (widget.animate) {
        setState(() {
          controller.reverse();
        });
      }
    }

    void onTapHandler() {
      if (widget.disabled) {
        return;
      }
      if (!widget.card.isCardPlayable()) {
        return;
      }
      if (widget.onTap != null) {
        widget.onTap!();
        return;
      }
      if (widget.card.targetType == TargetEnum.singleTarget) {
        if (cardId == gameState.selectingTargetCardId) {
          gameState.stopSelecting();
          return;
        }
        gameState.startSelecting(widget.card, cardId);
        return;
      } else if (widget.card.targetType == TargetEnum.cardTarget) {
        // TODO: implement some random fuzzy logic to select a targe
        // gameState.playTheCard(widget.card, gameState.currentRoom!.enemies);
        gameState.startSelecting(widget.card, cardId);
        return;
      } else {
        gameState.playTheCard(widget.card, gameState.currentRoom!.enemies);
        return;
      }
    }

    double width = MediaQuery.of(context).size.width;
    double cardWidth = widget.size ?? defaultWidth;

    return GestureDetector(
      onTap: onTapHandler,
      child: MouseRegion(
        onEnter: onEnterHandler,
        onExit: onExitHandler,
        child: Container(
          height: cardWidth + 8,
          width: cardWidth + 8,
          margin: EdgeInsets.fromLTRB(
              4,
              4,
              4,
              gameState.selectingTargetCardId == cardId
                  ? cardWidth * 1
                  : animation.value),
          child: Center(
            child: Stack(children: [
              if (widget.disabled == false &&
                  widget.glow &&
                  playerMana >= widget.card.getMana() &&
                  widget.card.isCardPlayable())
                Center(
                  child: GlowEffectCard(
                      child: SizedBox(
                    height: calcHeightByWidth(cardWidth),
                    width: cardWidth,
                  )),
                ),
              if (widget.glow && widget.card.isCardBoosted())
                Center(
                  child: GlowEffectCard(
                      waveColor: wavecolor,
                      child: SizedBox(
                        height: calcHeightByWidth(cardWidth),
                        width: cardWidth,
                      )),
                ),
              Center(
                  child: Container(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.fromLTRB(0, 0, 0, cardWidth / 2.5),
                height: calcHeightByWidth(cardWidth / 2),
                width: cardWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.card.asset),
                      fit: BoxFit.fitWidth),
                ),
              )),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // margin: const EdgeInsets.all(4),
                  height: calcHeightByWidth(cardWidth),
                  width: cardWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/card_front_full.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: calcHeightByWidth(cardWidth),
                        width: cardWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.fromLTRB(0, cardWidth / 40, 0, 0),
                              child: Text(
                                widget.card.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        16 * (widget.size! / defaultWidth)),
                              ),
                            ),
                            Container(
                              height: calcHeightByWidth(cardWidth) * 0.3,
                              margin: EdgeInsets.fromLTRB(
                                  width / 35, 0, width / 35, 0),
                              child: Column(
                                children: [
                                  widget.card.getCardDescription(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.card.isCardPlayable())
                        Positioned(
                          top: 8,
                          left: cardWidth / 24,
                          child: Container(
                            width: 24 * (cardWidth / defaultWidth),
                            height: 24 *
                                (calcHeightByWidth(cardWidth) / defaultHeight),
                            // padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFC99C66),
                                borderRadius: BorderRadius.circular(
                                    24 * (cardWidth / defaultWidth)),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: Center(child: widget.card.getCardMana()),
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

double calcHeightByWidth(double width) =>
    (width / defaultWidth) * defaultHeight;
