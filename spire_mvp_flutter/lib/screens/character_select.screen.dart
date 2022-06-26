import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/character_card.dart';
import 'package:spire_mvp_flutter/components/menu_embark_button.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

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
                padding: EdgeInsets.fromLTRB(300, 0, 300, 40),
                child: Consumer<GamestateController>(
                    builder: (gameStateContext, gameStateState, child) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: gameStateState.playableCharacters
                          .map((e) => CharacterCard(
                                heading: 'Standard',
                                img: '${e.name}.png',
                                description:
                                    "Standard mode is the default mode. It is the most common mode for players.",
                              ))
                          .toList());
                }),
              )
            ],
          ),
          const MenuBackButton(
            backScreen: ScreenEnum.modeSelect,
          ),
          // const MenuEmbarkButton(
          //   backScreen: ScreenEnum.game,
          // ),
        ],
      ),
    );
  }
}
