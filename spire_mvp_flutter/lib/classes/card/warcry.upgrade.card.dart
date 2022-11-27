import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';

import '../../enums/target.enum.dart';
import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

class WarCryUpgradeCard extends PlayableCard {
  int draw = 2;
  int maxSelectableCards = 1;

  WarCryUpgradeCard(
      {cardName = 'Warcry+',
      cardDescription =
          'Draw 1(2) card(s). Place a card from your hand on top of your draw pile. Exhaust.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardSteps: 1,
            cardMaxSteps: 3,
            cardExhaused: true,
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.warcryCardUpgradeName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localDraw = draw;

    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .applyDrawEffectDescription(localDraw.toString())),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!
                  .placeCardFromDiscardToDrawEffectDescription),
          HighlightDescriptionText(
              text: AppLocalizations.of(context)!.exhaustMechanic)
        ],
      ),
    );
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();

    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);

    if (isBishopStatus && mana == 1) return 0;

    return mana;
  }

  @override
  List<PlayableCard> getSelectableCards() {
    return Player.getPlayerInstance().getCharacter().getDeck().getHand();
  }

  @override
  int getMaxSelectableCards() {
    int localMaxSelectableCards = maxSelectableCards;
    return localMaxSelectableCards;
  }

  @override
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    if (step == 1) {
      int localDraw = draw;
      character.deck.draw(localDraw);
      step++;
      targetType = TargetEnum.cardTarget;
    } else {
      if (selectedCards.isNotEmpty) {
        List<PlayableCard> hand = character.deck.getHand();
        List<PlayableCard> drawPile = character.deck.getDrawPile();

        drawPile.insert(0, selectedCards[0]);
        hand.remove(selectedCards[0]);
        setSelectedCards([]);
      }
      targetType = TargetEnum.allTargets;
      step = 1;
    }
  }
}
