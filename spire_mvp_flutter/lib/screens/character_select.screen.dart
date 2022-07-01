import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/character_card.dart';
import 'package:spire_mvp_flutter/components/menu_embark_button.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/character.util.dart';

import '../components/menu_back_button.dart';
import '../enums/screens.enum.dart';

class CharacterSelect extends StatefulWidget {
  const CharacterSelect({Key? key}) : super(key: key);

  @override
  State<CharacterSelect> createState() => _CharacterSelectState();
}

class _CharacterSelectState extends State<CharacterSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Consumer<GamestateController>(
              builder: (gameStateContext, gameStateState, child) {
            if (gameStateState.playerCharacter == null) {
              return Container();
            } else {
              var assetName =
                  getCharacterAssetByName(gameStateState.playerCharacter);
              return Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(assetName), fit: BoxFit.cover),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(150, 250, 0, 0),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameStateState.playerCharacter!.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'HP: ${gameStateState.playerCharacter!.maxHealth} / ${gameStateState.playerCharacter!.health}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        Text(
                          // gameStateState.playerCharacter!.description,
                          'The remaining soldier of the Ironclads.\nSold his soul to harness demonice energies.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ]),
                )
              ]);
            }
          }),
          Column(
            // color: Colors.blue,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<GamestateController>(
                  builder: (gameStateContext, gameStateState, child) {
                return Text(
                  'Game mode ${gameStateState.gameMode.toString()}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const Spacer(flex: 1),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    children: [
                      const Spacer(flex: 1),
                      Consumer<GamestateController>(
                          builder: (gameStateContext, gameStateState, child) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: gameStateState.playableCharacters
                                .map((e) => CharacterCard(
                                      character: e,
                                    ))
                                .toList());
                      }),
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
