import 'package:flutter/material.dart';

import 'package:mathpunk_cardgame/classes/player/player_character/priest_character.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/barbarian_character.dart';
import 'package:mathpunk_cardgame/components/character_card.dart';
import 'package:mathpunk_cardgame/components/menu_embark_button.dart';
import 'package:mathpunk_cardgame/screens/character_select/character_select_card.screen.dart';

import '../../components/menu_back_button.dart';
import '../../enums/screens.enum.dart';

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
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/character_select_bg.png'),
                  fit: BoxFit.fitWidth),
            ),
          ),
          const CharacterSelectCard(),
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
