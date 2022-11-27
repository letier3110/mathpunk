import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';
// import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

// bool disposeToDiscard(List<PlayableCard> hand, List<PlayableCard> discardPile) {
//   if (!ethereal) {
//     discardPile.add(this);
//   }
//   hand.remove(this);
//   return true;
// }

bool isCardPlayable(PlayableCard card, int playerMana) {
  if (card.currentState == CardState.inHand && playerMana >= card.getMana()) {
    return true;
  }
  return false;
}

// bool _checkIfCardPlayable(PlayableCard card) {
  //   if (playerCharacter == null) return false;
  //   if (state.currentRoom == null) return false;
  //   if (playerCharacter!.mana < card.getMana()) return false;
  //   // if (card.isCardPlayable() == false) return false;
  //   if (playerCharacter!
  //       .getDeck()
  //       .getHand()
  //       .where((x) => x.runtimeType == NormalityCard)
  //       .isNotEmpty) {
  //     if (playerCharacter!.cardsPlayedInRound >= 3) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }