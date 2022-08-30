import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/saves.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class CharacterName extends StatefulWidget {
  const CharacterName({Key? key}) : super(key: key);

  @override
  State<CharacterName> createState() => CharacterNameView();
}

class CharacterNameView extends State<CharacterName> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);
    SavesController saves = Provider.of<SavesController>(context);

    var playerName = saves.saveSlots[saves.currentSaveSlot ?? 0];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              playerName,
              // '$height',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: getFontSize(22),
                  fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(
                gameState.playerCharacter?.name ?? 'no class',
                // '$width',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
    );
  }
}
