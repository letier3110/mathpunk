import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/screens/character_select/character_bg.dart';
import 'package:mathpunk_cardgame/screens/character_select/character_description_consumer.dart';

class CharacterSelectCard extends StatefulWidget {
  const CharacterSelectCard({Key? key}) : super(key: key);

  @override
  State<CharacterSelectCard> createState() => _CharacterSelectCardState();
}

class _CharacterSelectCardState extends State<CharacterSelectCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, width / 100),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(children: [
              SizedBox(
                width: (width * 7) / 100,
              ),
              const CharacterBg(),
              SizedBox(
                width: width * 2.9 / 30,
              ),
              const CharacterDescriptionConsumer(),
            ]),
          ),
        ],
      ),
    );
  }
}
