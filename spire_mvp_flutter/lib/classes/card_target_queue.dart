import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

class CardTargetQueue {
  PlayableCard card;
  List<BaseCharacter> target;

  CardTargetQueue({required this.card, required this.target});
}
