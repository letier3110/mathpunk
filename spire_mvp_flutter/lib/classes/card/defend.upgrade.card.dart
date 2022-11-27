import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/components/highlight_text.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

import '../base_character.dart';

import '../../enums/card_type.enum.dart';
import 'playable_card.dart';

class DefendUpgradeCard extends PlayableCard {
  int block = 8;

  DefendUpgradeCard(
      {cardName = 'Defend+',
      cardDescription = 'Gain 8 Block.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardTemporary: cardTemporary,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.skill,
            cardTargetType: TargetEnum.allTargets);

  @override
  StatelessWidget getCardName(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.defendCardUpgradeName,
      style: TextStyle(color: getUpgradedCardColor(), fontSize: 16),
    );
  }

  @override
  StatelessWidget getCardDescription(BuildContext context) {
    int finalBlock = predictBlock(block: block, mana: mana);
    return Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: AppLocalizations.of(context)!.gainStartDescription),
              TextSpan(
                  text: AppLocalizations.of(context)!
                      .dealBlockNumber(finalBlock.toString()),
                  style: TextStyle(
                      color: finalBlock > block
                          ? Colors.greenAccent
                          : finalBlock < block
                              ? Colors.redAccent
                              : Colors.white,
                      fontSize: 14)),
              TextSpan(
                  text: AppLocalizations.of(context)!.blockEffectDescriptionEnd)
            ],
          )),
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
  play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    character.addCardsPlayedInRound(1);
    BlockStatus bs = BlockStatus();
    bs.addStack(block.toDouble());
    character.addStatus(bs);
  }
}
