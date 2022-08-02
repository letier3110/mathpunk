import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

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
                          padding: const EdgeInsets.only(bottom: 8),
                          child: const Icon(
                            Icons.local_bar,
                            color: Colors.pinkAccent,
                          ),
                        ),
                        Text(
                          e.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.pinkAccent,
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