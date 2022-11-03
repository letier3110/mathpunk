import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class RingOfSerpent extends Relic {
  RingOfSerpent(
      {relicName = 'Ring of the Serpent',
      relicDescription = 'At the start of your turn, draw 1 additional card.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    Player.getPlayerInstance().getCharacter().getDeck().draw(1);
  }

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.ringOfTheSerpentName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.ringOfTheSerpentDescription;

  static bool isRelicRingOfSerpent(Relic relic) {
    return relic.runtimeType == RingOfSerpent;
  }

  @override
  String getAssetImage() {
    return 'assets/relics/ring_of_serpent.png';
  }

  factory RingOfSerpent.fromJson(dynamic json) {
    return RingOfSerpent(
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
