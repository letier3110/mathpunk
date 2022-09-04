import 'package:mathpunk_cardgame/classes/relic/relic.dart';

class ArtOfWar extends Relic {
  ArtOfWar(
      {relicName = 'Art of War',
      relicDescription =
          'If you do not play any Attacks during your turn, gain an extra Energy next turn.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

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
