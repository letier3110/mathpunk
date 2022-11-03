import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class WristBlade extends Relic {
  WristBlade(
      {relicName = 'Wrist Blade',
      relicDescription = 'Attacks that cost 0 deal 4 additional damage.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.wristBladeName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.wristBladeDescription;

  static bool isRelicWristBlade(Relic relic) {
    return relic.runtimeType == WristBlade;
  }

  factory WristBlade.fromJson(dynamic json) {
    return WristBlade(
      relicName: json['name'] as String,
      relicDescription: json['description'] as String,
    );
  }

  @override
  String getAssetImage() {
    return 'assets/relics/wrist_blade.png';
  }

  @override
  Map toJson() => {
        'name': name,
        'description': description,
      };
}
