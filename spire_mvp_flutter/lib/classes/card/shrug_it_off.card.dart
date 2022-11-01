import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/card/shrug_it_off.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import '../player/player.dart';
import 'playable_card.dart';

class ShrugItOffCard extends PlayableCard {
  int block = 8;
  int draw = 1;

  ShrugItOffCard(
      {cardName = 'Shrug it Off',
      cardDescription = 'Gain 8(11) Block. Draw 1 card.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardTargetType: TargetEnum.allTargets,
            cardType: CardType.skill,
            cardUpgrageLink: ShrugItOffUpgradeCard());

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int localBlock = block;
    int localDraw = draw;
    return Container(
      child: Column(
        children: [
          HighlightDescriptionText(text: 'Gain $localBlock Block.'),
          HighlightDescriptionText(text: 'Draw $localDraw card.')
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
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    int localBlock = block;
    int localDraw = draw;

    BlockStatus bs = BlockStatus();
    bs.addStack(localBlock.toDouble());
    character.addStatus(bs);

    character.deck.draw(localDraw);
  }
}
