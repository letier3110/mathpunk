import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/storage/character.storage.dart';

final playerCharacterProvider =
    StateNotifierProvider<PlayerCharacterNotifier, PlayerCharacter?>((ref) {
  return PlayerCharacterNotifier();
});

class PlayerCharacterNotifier extends StateNotifier<PlayerCharacter?> {
  PlayerCharacterNotifier() : super(null);

  void deselectCharacter() {
    state = null;
  }

  void receiveDamage(int damage) {
    state!.receiveDamage(damage);
    _updateState();
  }

  void selectCharacter(PlayerCharacter character) {
    state = character;
    Player player = Player();
    player.selectCharacter(character);
  }

  void addGold(int goldValue) {
    state!.gold += goldValue;
    _updateState();
  }

  void heal(int damage) {
    state!.heal(damage);
    _updateState();
  }

  void addCardsPlayedInRound(int cardsPlayedInRound) {
    state!.addCardsPlayedInRound(cardsPlayedInRound);
    _updateState();
  }

  void addCardToDiscardPile(PlayableCard card) {
    state!.getDeck().addToDiscardPile(card);
    _updateState();
  }

  void addStatus(Status status) {
    state!.addStatus(status);
  }

  void insertNewCardInHandAndRemoveOther(
      PlayableCard insertedCard, PlayableCard toRemoveCard) {
    List<PlayableCard> hand = state!.deck.getHand();
    hand.insert(0, insertedCard);
    hand.remove(toRemoveCard);
  }

  void _updateState() {
    state = playerCharacterFromJson(playerCharacterToJson(state!));
  }
}
