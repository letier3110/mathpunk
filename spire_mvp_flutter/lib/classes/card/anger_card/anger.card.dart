import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';

import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.description.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.name.dart';
import 'package:mathpunk_cardgame/classes/card/anger_card/anger_card.stats.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/statuses/bishop.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/math_multiplier_score.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/enums/card_type.enum.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';

class AngerCard extends PlayableCard {
  AngerCard(
      {cardName = 'Anger',
      cardDescription = 'Deal 6 damage.',
      cardMana = 1,
      cardTemporary = false})
      : super(
            cardName: cardName,
            cardDescription: cardDescription,
            cardMana: cardMana,
            cardType: CardType.attack,
            cardUpgrageLink: AngerUpgradeCard(),
            cardTemporary: cardTemporary);

  @override
  StatefulWidget getCardName() {
    return const AngerCardName();
  }

  @override
  StatefulWidget getCardDescription() {
    return const AngerCardDescription();
  }

  @override
  int getMana() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    bool isBishopStatus = castStatusToBool(statuses, BishopStatus);
    if (isBishopStatus && AngerCardStats.mana == 1) return 0;
    return AngerCardStats.mana;
  }

  @override
  bool isCardBoosted() {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    List<Status> statuses = character.getStatuses();
    double mathMultiplierScore =
        castStatusToDouble(statuses, MathMultiplierScoreStatus);
    return mathMultiplierScore > 0;
  }

  // @override
  // play(List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
  //   // dispatch(dealDamageAction(target, damage));
  //   // dispatch(addCardToDiscardPile(target, damage));

  //   // await dealDamageStream
  //   // await dealDamageStream
  //   // await dealDamageStream
  //   // await dealDamageStream

  //   if (target.length == 1) {
  //     target[0].receiveDamage(calculateDamage(
  //         character: playerCharacter.getCharacter(),
  //         damage: AngerCardStats.damage,
  //         precision: precision,
  //         mana: AngerCardStats.mana));
  //   }
  //   playerCharacter.addCardToDiscardPile(this);
  // }

  @override
  Stream<void> play(
      List<BaseCharacter> target, PlayerCharacterNotifier playerCharacter) {
    late StreamController<int> controller;
    Timer? timer;

    void tick(_) {
      if (target.length == 1) {
        target[0].receiveDamage(calculateDamage(
            character: playerCharacter.getCharacter(),
            damage: AngerCardStats.damage,
            precision: precision,
            mana: AngerCardStats.mana));
      }
      playerCharacter.addCardToDiscardPile(this);
      timer?.cancel();
      controller.close();
    }

    void startTimer() {
      timer = Timer.periodic(Duration.zero, tick);
    }

    void stopTimer() {
      timer?.cancel();
      timer = null;
    }

    controller = StreamController(
        onListen: startTimer,
        onPause: stopTimer,
        onResume: startTimer,
        onCancel: stopTimer);

    return controller.stream;
  }
}

// // NOTE: This implementation is FLAWED!
// // It starts before it has subscribers, and it doesn't implement pause.
// Stream<int> timedCounter(Duration interval, [int? maxCount]) {
//   var controller = StreamController<int>();
//   int counter = 0;
//   void tick(Timer timer) {
//     counter++;
//     controller.add(counter); // Ask stream to send counter values as event.
//     if (maxCount != null && counter >= maxCount) {
//       timer.cancel();
//       controller.close(); // Ask stream to shut down and tell listeners.
//     }
//   }

//   Timer.periodic(interval, tick); // BAD: Starts before it has subscribers.
//   return controller.stream;
// }