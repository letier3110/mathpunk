import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';
import 'package:mathpunk_cardgame/storage/character.storage.dart';

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
    _updateState();
  }

  void addGold(int goldValue) {
    state!.gold += goldValue;
    _updateState();
  }

  void addMana(int mana) {
    state!.addMana(mana);
    _updateState();
  }

  void heal(int damage) {
    state!.heal(damage);
    _updateState();
  }

  void addMaxHp(int maxHealth) {
    state!.setMaxHealth(state!.maxHealth + maxHealth);
    state!.heal(state!.health + maxHealth);
    _updateState();
  }

  void healMaxPercentage(double percentage) {
    state!.heal((state!.maxHealth * percentage).floor());
    _updateState();
  }

  void addCardsPlayedInRound(int cardsPlayedInRound) {
    state!.addCardsPlayedInRound(cardsPlayedInRound);
    _updateState();
  }

  void addShivCardToHand() {
    state!.getDeck().getHand().add(ShivCard());
    _updateState();
  }

  void addCardToDiscardPile(PlayableCard card) {
    card.currentState = CardState.inDiscardPile;
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

  void armamentsPlayEffect(PlayableCard upgradeCard) {
    List<PlayableCard> hand = state!
        .getDeck()
        .getHand()
        .where((card) => card.isCardCanBeUpgraded() && card != upgradeCard)
        .toList();
    state!.getDeck().hand = hand.map((card) => card.upgradeCard()).toList();
  }

  List<Status> getStatuses() => state!.getStatuses();

  PlayerCharacter getCharacter() => state!;

  void _updateState() {
    state = playerCharacterFromJson(playerCharacterToJson(state!));
  }
}
