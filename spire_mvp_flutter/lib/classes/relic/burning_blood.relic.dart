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
