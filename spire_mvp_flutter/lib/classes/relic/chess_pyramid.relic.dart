import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/probability.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/king.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/pawn.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/queen.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/rook.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';

List<Probability<Status>> _piecesPool = [
  Probability(obj: PawnStatus(), weight: 30),
  Probability(obj: RookStatus(), weight: 15),
  Probability(obj: KnightStatus(), weight: 20),
  Probability(obj: BishopStatus(), weight: 20),
  Probability(obj: QueenStatus(), weight: 5),
  Probability(obj: KingStatus(), weight: 10)
];

class ChessPyramid extends Relic {
  ChessPyramid(
      {relicName = 'Chess pyramid',
      relicDescription = 'Summon powerful chess piece to help you.'})
      : super(relicDescription: relicDescription, relicName: relicName);

  @override
  void play() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    Status s = weightedRandomPick(_piecesPool).obj;

    s.addStack(1);

    character.addStatus(s);
  }

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.chessPyramidName;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.chessPyramidDescription;

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
