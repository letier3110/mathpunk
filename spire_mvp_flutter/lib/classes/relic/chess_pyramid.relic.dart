import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/probability.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';

List<Probability<Status>> _piecesPool = [
  Probability(obj: StrengthStatus(), weight: 500)
];

class ChessPyramid extends Relic {
  ChessPyramid(
      {relicName = 'Chess pyramid',
      relicDescription = 'Summon powerful chess piece to help you.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    // weightedRandomPick(_piecesPool);
    // Player.getPlayerInstance().getCharacter()
  }

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
