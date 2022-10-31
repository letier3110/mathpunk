import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class BurningBloodRelic extends Relic {
  BurningBloodRelic(
      {relicName = 'Burning Blood',
      relicDescription = 'At the end of combat, heal 6 HP.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    Player.getPlayerInstance().getCharacter().heal(6);
  }

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.burningBloodName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.burningBloodDescription;

  static bool isRelicBurningBlood(Relic relic) {
    return relic.runtimeType == BurningBloodRelic;
  }

  factory BurningBloodRelic.fromJson(dynamic json) {
    return BurningBloodRelic(
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
