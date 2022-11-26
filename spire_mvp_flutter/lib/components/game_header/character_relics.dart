import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CharacterRelics extends ConsumerStatefulWidget {
  const CharacterRelics({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterRelics> createState() => CharacterRelicsView();
}

class CharacterRelicsView extends ConsumerState<CharacterRelics> {
  bool _isShowTooltip = false;
  Relic? selectedRelic;

  void _showTooltip(Relic relic) {
    setState(() {
      _isShowTooltip = true;
      selectedRelic = relic;
    });
  }

  void _hideTooltip() {
    setState(() {
      _isShowTooltip = false;
      selectedRelic = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final relics = ref
        .watch(playerCharacterProvider.select((value) => value?.relics ?? []));

    return SizedBox(
      height: 360,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 100,
            margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: SizedBox(
              height: 90,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: relics
                      .where((element) => element.isVisible())
                      .map((e) => MouseRegion(
                            onEnter: (event) => _showTooltip(e),
                            onExit: (event) => _hideTooltip(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  padding: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(e.getAssetImage()),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Text(
                                  e.getNameTranslationKey(context),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ))
                      .toList()),
            ),
          ),
          if (_isShowTooltip && selectedRelic != null)
            Positioned(
              bottom: 0,
              child: Container(
                width: 240,
                height: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu_bg_2.png'),
                      fit: BoxFit.fill),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: [
                    const Spacer(),
                    Text(
                      selectedRelic!.getNameTranslationKey(context),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    HighlightDescriptionText(
                      text:
                          selectedRelic!.getDescriptionTranslationKey(context),
                      fontSize: 14,
                    ),
                    const Spacer(),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
