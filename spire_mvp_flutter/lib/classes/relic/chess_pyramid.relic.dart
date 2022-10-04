import 'package:mathpunk_cardgame/classes/relic/relic.dart';

int count = 3;

class ChessPyramid extends Relic {
  ChessPyramid(
      {relicName = 'Chess pyramid',
      relicDescription = 'Summon powerful chess piece to help you.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {}

  static bool isRelicChessPyramid(Relic relic) {
    return relic.runtimeType == ChessPyramid;
  }

  factory ChessPyramid.fromJson(dynamic json) {
    return ChessPyramid(
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
