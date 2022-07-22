import 'package:spire_mvp_flutter/classes/base_character.dart';

import '../enums/intension_type.enum.dart';
import 'intension.dart';
import 'player/player.dart';

class Moveset {
  List<Intension> moves = [];
  Intension? currentMove;
  // Enemy parent;

  // Moveset(Enemy enemyParent) {
  Moveset() {
    moves = [Intension(intensionType: IntensionType.offense)];
    // parent = enemyParent;
    currentMove = null;
    // array of moves
    // get next move
    // react to player actions
    // react to stats change
  }

  void setMoves(List<Intension> newMoves) {
    moves = newMoves;
  }

  void setCurrentMove(Intension currentMove) {
    currentMove = currentMove;
  }

  executeMove(BaseCharacter character) {
    if (currentMove?.type == IntensionType.offense) {
      var player = Player.getPlayerInstance();
      var character = player.getCharacter();
      double localDamage = currentMove!.baseDamage.toDouble();
      if (character.weak > 1) {
        localDamage = localDamage * 0.75;
      }
      for (var i = 0; i < currentMove!.count; i++) {
        character.recieveDamage(localDamage.floor());
      }
    }
  }

  getNextMove() {
    // Rotate array
    var move = moves.first;
    if (moves.isNotEmpty) {
      moves = moves.sublist(1);
      currentMove = move;
      moves.add(move);
    }
  }

  factory Moveset.fromJson(dynamic json) {
    List<Intension> jsonMoves =
        (json['moves'] as List).map((e) => Intension.fromJson(e)).toList();

    Intension jsonCurrentIntension = Intension.fromJson(json['currentMove']);

    Moveset jsonMoveset = Moveset();
    jsonMoveset.setMoves(jsonMoves);
    jsonMoveset.setCurrentMove(jsonCurrentIntension);

    return jsonMoveset;
  }

  Map toJson() => {
        'moves': moves,
        'currentMove': currentMove,
      };
}
