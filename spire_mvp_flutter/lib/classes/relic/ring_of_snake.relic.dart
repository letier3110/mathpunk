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

  static bool isRelicRingOfSnake(Relic relic) {
    return relic.runtimeType == RingOfSnake;
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
