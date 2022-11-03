import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class CharacterItems extends StatefulWidget {
  const CharacterItems({Key? key}) : super(key: key);

  @override
  State<CharacterItems> createState() => CharacterItemsView();
}

class CharacterItemsView extends State<CharacterItems> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    var items = gameState.playerCharacter?.items ?? [];

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(328, 0, 0, 0),
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: items
              .map((e) => SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(e.getAssetImage()),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Text(
                          e.getItemName(context),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
