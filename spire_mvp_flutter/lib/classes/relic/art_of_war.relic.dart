import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class ArtOfWar extends Relic {
  ArtOfWar(
      {relicName = 'Art of War',
      relicDescription =
          'If you do not play any Attacks during your turn, gain an extra Energy next turn.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.artOfWarName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.artOfWarDescription;

  static bool isRelicArtOfWar(Relic relic) {
    return relic.runtimeType == ArtOfWar;
  }

  factory ArtOfWar.fromJson(dynamic json) {
    return ArtOfWar(
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
