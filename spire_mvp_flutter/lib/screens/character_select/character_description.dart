import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';

class CharacterDescription extends StatefulWidget {
  final PlayerCharacter playerCharacter;
  const CharacterDescription({required this.playerCharacter, Key? key})
      : super(key: key);

  @override
  State<CharacterDescription> createState() => _CharacterDescriptionState();
}

class _CharacterDescriptionState extends State<CharacterDescription> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = widget.playerCharacter;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding:
          EdgeInsets.fromLTRB(width / 30, width / 30, width / 30, width / 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            playerCharacter.getNameTranslationKey(context),
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Text(
              AppLocalizations.of(context)!.hpbarText(
                  playerCharacter.health.toString(),
                  playerCharacter.maxHealth.toString()),
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
              playerCharacter.getDescriptionTranslationKey(context),
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          if (playerCharacter.relics.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                  children: playerCharacter.relics
                      .map((e) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 9,
                                child: Text(
                                  '${e.getNameTranslationKey(context)}: ',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: width / 6,
                                child: Text(
                                  '''
${e.getDescriptionTranslationKey(context)}
''',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ))
                      .toList()),
            ),
        ],
      ),
    );
  }
}
