import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class RingOfSnake extends Relic {
  RingOfSnake(
      {relicName = 'Ring of the Snake',
      relicDescription =
          'At the start of each combat, draw 2 additional cards.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    Player.getPlayerInstance().getCharacter().getDeck().draw(2);
  }

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.ringOfTheSnakeName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.ringOfTheSnakeDescription;

  static bool isRelicRingOfSnake(Relic relic) {
    return relic.runtimeType == RingOfSnake;
  }

  @override
  String getAssetImage() {
    return 'assets/relics/ring_of_snake.png';
  }

  factory RingOfSnake.fromJson(dynamic json) {
    return RingOfSnake(
      relicName: json['name'] as String,
      relicDescription: json['description'] as String,
    );
  }

  @override
  Map toJson() => {
        'name': name,
        'description': description,
      };
}
