import 'package:mathpunk_cardgame/classes/relic/relic.dart';

int count = 3;

class BlackPawn extends Relic {
  BlackPawn(
      {relicName = 'Black Pawn', relicDescription = 'Upgrades random card.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

  static bool isRelicBlackPawn(Relic relic) {
    return relic.runtimeType == BlackPawn;
  }

  factory BlackPawn.fromJson(dynamic json) {
    return BlackPawn(
      relicName: json['name'] as String,
      relicDescription: json['description'] as String,
    );
  }

  @override
  String getAssetImage() {
    return 'assets/relics/chess_pyramid.png';
  }

  @override
  Map toJson() => {
        'name': name,
        'description': description,
      };
}
