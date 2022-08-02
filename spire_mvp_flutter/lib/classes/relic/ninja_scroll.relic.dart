import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';

int count = 3;

class NinjaScroll extends Relic {
  NinjaScroll(
      {relicName = 'NinjaScroll',
      relicDescription = 'Start each combat with 3 Shivs in hand.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    for (var i = 0; i < 3; i++) {
      Player.getPlayerInstance()
          .getCharacter()
          .getDeck()
          .getHand()
          .add(ShivCard());
    }
  }

  static bool isRelicNinjaScroll(Relic relic) {
    return relic.runtimeType == NinjaScroll;
  }

  factory NinjaScroll.fromJson(dynamic json) {
    return NinjaScroll(
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
