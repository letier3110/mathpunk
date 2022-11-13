import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/storage/character.storage.dart';

final dealDamageCardEffectProvider =
    StreamProvider.autoDispose<int>((ref) async* {
  // Open the connection
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  // Close the connection when the stream is destroyed
  ref.onDispose(() => channel.sink.close());

  // Parse the value received and emit a Message instance
  await for (final value in channel.stream) {
    yield value.toString();
  }
});

class DealDamageCardEffectNotifier extends StreamProvider<int> {
  DealDamageCardEffectNotifier() : super(0);

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
