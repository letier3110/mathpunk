import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';

class CardDescription extends ConsumerStatefulWidget {
  final List<CardEffect> effects;
  const CardDescription({this.effects = const [], Key? key}) : super(key: key);

  @override
  ConsumerState<CardDescription> createState() {
    return CardDescriptionState();
  }
}

class CardDescriptionState extends ConsumerState<CardDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.effects
            .where((element) => element.isShown)
            .map((e) => e.getCardEffectDescription())
            .toList(),
      ),
    );
  }
}
