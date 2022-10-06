import 'package:mathpunk_cardgame/classes/relic/relic.dart';

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
  String getAssetImage() {
    return 'assets/relics/wrist_blade.png';
  }

  @override
  Map toJson() => {
        'name': name,
        'description': description,
      };
}
