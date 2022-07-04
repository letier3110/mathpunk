import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/components/playable_card/glow_effect.view.dart';

class PlayableCardComponent extends StatefulWidget {
  final PlayableCard card;
  const PlayableCardComponent({required this.card, Key? key}) : super(key: key);

  @override
  State<PlayableCardComponent> createState() => PlayableCardComponentView();
}

class PlayableCardComponentView extends State<PlayableCardComponent> {
  @override
  Widget build(BuildContext context) {
    return GlowEffect(
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
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        Text(
                          widget.card.description,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
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
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
