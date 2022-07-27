import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class CharacterRelics extends StatefulWidget {
  const CharacterRelics({Key? key}) : super(key: key);

  @override
  State<CharacterRelics> createState() => CharacterRelicsView();
}

class CharacterRelicsView extends State<CharacterRelics> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var relics = gameState.playerCharacter?.relics ?? [];

    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: relics
              .map((e) => SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Icon(
                            Icons.sports_mma,
                            color: Colors.greenAccent,
                          ),
                        ),
                        Text(
                          e.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
