import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/components/highlight_text.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import '../util.dart';
import 'playable_card.dart';

int damage = 9;
int draw = 1;

class PommelStrikeCard extends PlayableCard {
  PommelStrikeCard(
      {cardName = 'Pommel Strike',
      cardDescription = 'Deal 9(10) damage. Draw 1(2) card(s).',
      cardMana = 1,
      cardDamage = 5})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack);

  @override
  StatelessWidget getCardDescription() {
    int localDraw = draw;
    return HighlightDescriptionText(
        text:
            'Deal ${calculateDamage(damage: damage, mana: mana)} damage.\nDraw $localDraw card.');
  }

  @override
  play(List<BaseCharacter> target) {
    if (target.length == 1) {
      target[0].recieveDamage(calculateDamage(damage: damage, mana: mana));
      int localDraw = draw;
      PlayerCharacter character = Player.getPlayerInstance().getCharacter();
      character.deck.draw(localDraw);
    }
  }
}
