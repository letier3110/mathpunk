import '../enums/intension_type.dart';
import 'intension.dart';
import 'player.dart';

class Moveset {
  late List<Intension> moves;
  Intension? currentMove;
  // Enemy parent;

  // Moveset(Enemy enemyParent) {
  Moveset() {
    moves = [Intension(intensionType: IntensionType.offense)];
    // parent = enemyParent;
    currentMove = null;
    getNextMove();
    // array of moves
    // get next move
    // react to player actions
    // react to stats change
  }

  executeMove() {
    if (currentMove?.type == IntensionType.offense) {
      var player = Player.getPlayerInstance();
      var character = player.getCharacter();
      character.changeHealth(currentMove!.baseDamage * currentMove!.count);
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
}
