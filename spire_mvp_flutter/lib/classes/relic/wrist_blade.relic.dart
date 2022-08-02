import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';

int count = 3;

class WristBlade extends Relic {
  WristBlade(
      {relicName = 'Wrist Blade',
      relicDescription = 'Attacks that cost 0 deal 4 additional damage.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

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
  Map toJson() => {
        'name': name,
        'description': description,
      };
}
