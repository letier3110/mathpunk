import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/player/player_character/priest_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/barbarian_character.dart';
import 'package:mathpunk_cardgame/components/character_card.dart';
import 'package:mathpunk_cardgame/components/menu_embark_button.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/utils/character.util.dart';

import '../components/menu_back_button.dart';
import '../enums/screens.enum.dart';

class CharacterSelect extends ConsumerStatefulWidget {
  const CharacterSelect({Key? key}) : super(key: key);

  @override
  ConsumerState<CharacterSelect> createState() => _CharacterSelectState();
}

AssetImage pickCharacterImage(bool disabled, String assetName) {
  if (disabled) {
    return const AssetImage('assets/character_select_class.png');
  }
  return AssetImage(assetName);
}

AssetImage pickDescriptionImage(bool disabled, String assetName) {
  if (disabled) {
    return const AssetImage('assets/character_select_description.png');
  }
  return const AssetImage('assets/menu_bg_1.png');
}

class _CharacterSelectState extends ConsumerState<CharacterSelect> {
  @override
  Widget build(BuildContext context) {
    final gamestate = ref.watch(gamestateProvider);

    var assetName = getCharacterAssetByName(gamestate.playerCharacter);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/character_select_bg.png'),
                  fit: BoxFit.fitWidth),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, width / 100),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(children: [
                    SizedBox(
                      width: (width * 7) / 100,
                    ),
                    Container(
                      width: width * 3 / 8,
                      height: width / 4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: pickCharacterImage(
                                gamestate.playerCharacter == null, assetName),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: width * 2.9 / 30,
                    ),
                    Container(
                      width: width * 109 / 300,
                      height: width * 76 / 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: pickDescriptionImage(
                                gamestate.playerCharacter == null, assetName),
                            fit: BoxFit.cover),
                      ),
                      child: Row(children: [
                        if (gamestate.playerCharacter != null)
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                width / 30, width / 30, width / 30, width / 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  gamestate.playerCharacter!
                                      .getNameTranslationKey(context),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Text(
                                    AppLocalizations.of(context)!.hpbarText(
                                        gamestate.playerCharacter!.health
                                            .toString(),
                                        gamestate.playerCharacter!.maxHealth
                                            .toString()),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 1 / 4,
                                  child: Text(
                                    gamestate.playerCharacter!
                                        .getDescriptionTranslationKey(context),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                if (gamestate
                                    .playerCharacter!.relics.isNotEmpty)
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                    child: Column(
                                        children: gamestate
                                            .playerCharacter!.relics
                                            .map((e) => Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: width / 9,
                                                      child: Text(
                                                        '${e.getNameTranslationKey(context)}: ',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width / 6,
                                                      child: Text(
                                                        '''
${e.getDescriptionTranslationKey(context)}
''',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                            .toList()),
                                  ),
                              ],
                            ),
                          )
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Column(
            // color: Colors.blue,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   'Game mode ${gamestate.gameMode.toString()}',
              //   style: TextStyle(
              //     fontSize: getFontSize(30),
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              const Spacer(flex: 1),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      const Spacer(flex: 1),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Barbarian(), Priest()]
                              .map((e) => CharacterCard(
                                    character: e,
                                  ))
                              .toList()),
                      const Spacer(flex: 1),
                    ],
                  ))
            ],
          ),
          const MenuBackButton(
            backScreen: ScreenEnum.modeSelect,
          ),
          const MenuEmbarkButton(),
        ],
      ),
    );
  }
}
