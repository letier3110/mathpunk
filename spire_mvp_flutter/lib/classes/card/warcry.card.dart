import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';

import '../../enums/target.enum.dart';
import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

int draw = 1;

class WarCryCard extends PlayableCard {
  WarCryCard(
      {cardName = 'Warcry',
      cardDescription =
          'Draw 1(2) card(s). Place a card from your hand on top of your draw pile. Exhaust.',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardSteps: 1,
            cardMaxSteps: 3,
            cardExhaused: true,
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill);

  @override
  String getCardDescription() {
    int localDraw = draw;

    return 'Draw $localDraw card.\nPlace a card from your hand on top of your draw pile.\nExhaust.';
  }

  @override
  play(List<BaseCharacter> target) {
    if (step == 1) {
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      int localDraw = draw;
      character.deck.draw(localDraw);
    } else {
      // select card from hand

    }
    step++;
  }
}
