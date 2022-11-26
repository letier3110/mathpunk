import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/controllers/is_lore_card.provider.dart';

class LoreScreen extends ConsumerStatefulWidget {
  const LoreScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoreScreen> createState() => _LoreScreenState();
}

class _LoreScreenState extends ConsumerState<LoreScreen> {
  @override
  Widget build(BuildContext context) {
    final loreCard = ref.watch(isLoreCardProvider);

    void onCardTap() {
      ref.read(isLoreCardProvider.notifier).closeLoreCard();
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
                          card: loreCard!,
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
