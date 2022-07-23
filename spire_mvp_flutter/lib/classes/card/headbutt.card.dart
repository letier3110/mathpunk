import 'package:spire_mvp_flutter/classes/deck.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player_character/player_character.dart';
import 'playable_card.dart';

int damage = 9;
int maxSelectableCards = 1;

class HeadbuttCard extends PlayableCard {
  HeadbuttCard({
    cardName = 'Headbutt',
    cardDescription =
        'Deal 9(12) damage. Place a card from your discard pile on top of your draw pile.',
    cardMana = 1,
  }) : super(
            cardSteps: 1,
            cardMaxSteps: 3,
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  int calculateDamage() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localDamage = damage + character.strength;
    int weak = character.weak;
    if (weak > 0) {
      localDamage = (localDamage * 0.75).floor();
    }
    return localDamage;
  }

  @override
  String getCardDescription() {
    return 'Deal ${calculateDamage()} damage.\nPlace a card from your discard pile on top of your draw pile.';
  }

  @override
  List<PlayableCard> getSelectableCards() {
    return Player.getPlayerInstance().getCharacter().getDeck().getDiscardPile();
  }

  @override
  int getMaxSelectableCards() {
    int localMaxSelectableCards = maxSelectableCards;
    return localMaxSelectableCards;
  }

  @override
  play(List<BaseCharacter> target) {
    if (step == 1) {
      if (target.length == 1) {
        target[0].recieveDamage(calculateDamage());
        step++;
        targetType = TargetEnum.cardTarget;
      }
    } else {
      if (selectedCards.isNotEmpty) {
        Deck deck = Player.getPlayerInstance().getCharacter().getDeck();
        List<PlayableCard> discardPile = deck.getDiscardPile();
        List<PlayableCard> drawPile = deck.getDrawPile();

        discardPile.remove(selectedCards[0]);
        drawPile.insert(0, selectedCards[0]);
        setSelectedCards([]);
      }
      targetType = TargetEnum.singleTarget;
      step++;
    }
  }
}
