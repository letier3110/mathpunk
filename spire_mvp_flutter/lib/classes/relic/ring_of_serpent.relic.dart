import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/relic/relic.dart';

class RingOfSerpent extends Relic {
  RingOfSerpent(
      {relicName = 'Ring of the Serpent',
      relicDescription =
          // 'Replaces Ring of the Snake. At the start of your turn, draw 1 additional card.'})
          'At the start of your turn, draw 1 additional card.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    Player.getPlayerInstance().getCharacter().getDeck().draw(1);
  }

  static bool isRelicRingOfSerpent(Relic relic) {
    return relic.runtimeType == RingOfSerpent;
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
