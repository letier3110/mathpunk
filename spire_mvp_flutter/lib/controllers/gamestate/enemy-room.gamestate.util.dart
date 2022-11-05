import 'dart:math';

import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/chess_pyramid.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ninja_scroll.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_snake.relic.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/pawn.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/precision.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/queen.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';

void enemyRoomEnter({
  required Room currentRoom,
  required PlayerCharacter playerCharacter,
}) {
  if (currentRoom.runtimeType == EnemyRoom) {
    StrengthStatus ss = StrengthStatus();
    ss.addStack(5);
    DexterityStatus ds = DexterityStatus();
    ds.addStack(5);
    WeakStatus ws = WeakStatus();
    ws.addStack(5);
    playerCharacter.addStatus(ss);
    playerCharacter.addStatus(ds);
    playerCharacter.addStatus(ws);
    var deck = playerCharacter.getDeck();
    deck.initialLoadDrawPile();

    List<Relic> chessPyramid = playerCharacter.relics
        .where((element) => ChessPyramid.isRelicChessPyramid(element))
        .toList();
    if (chessPyramid.isNotEmpty) {
      chessPyramid[0].play();
    }

    List<Status> statuses = playerCharacter.getStatuses();

    // if pawn status => upgrade random card from deck forever
    bool isPawnStatus = castStatusToBool(statuses, PawnStatus);
    if (isPawnStatus == true) {
      final random = Random();
      int randomElement =
          random.nextInt(playerCharacter.getDeck().cards.length);
      while (playerCharacter
              .getDeck()
              .cards[randomElement]
              .isCardCanBeUpgraded() ==
          false) {
        randomElement = random.nextInt(playerCharacter.getDeck().cards.length);
      }
      playerCharacter.getDeck().cards[randomElement] =
          playerCharacter.getDeck().cards[randomElement].upgradeCard();
    }

    bool isKnightStatus = castStatusToBool(statuses, KnightStatus);
    if (isKnightStatus == true) {
      playerCharacter.getDeck().getHand().add(ShivCard());
    }

    bool isQueenStatus = castStatusToBool(statuses, QueenStatus);
    if (isQueenStatus == true) {
      StrengthStatus ss = StrengthStatus();
      DexterityStatus ds = DexterityStatus();
      PrecisionStatus ps = PrecisionStatus();
      ss.addStack(2);
      ds.addStack(2);
      ps.addStack(15);
      playerCharacter.addStatus(ss);
      playerCharacter.addStatus(ds);
      playerCharacter.addStatus(ps);
    }

    // if there are ring of snake => draw 2 cards at the start of combat
    List<Relic> ringOfSnake = playerCharacter.relics
        .where((element) => RingOfSnake.isRelicRingOfSnake(element))
        .toList();
    if (ringOfSnake.isNotEmpty) {
      ringOfSnake[0].play();
    }
    // if there are ring of snake => draw 1 cards at the start of combat
    List<Relic> ringOfSerpent = playerCharacter.relics
        .where((element) => RingOfSerpent.isRelicRingOfSerpent(element))
        .toList();
    if (ringOfSerpent.isNotEmpty) {
      ringOfSerpent[0].play();
    }
    // if there are ninja scroll => add 3 shivs
    List<Relic> ninjaScroll = playerCharacter.relics
        .where((element) => NinjaScroll.isRelicNinjaScroll(element))
        .toList();
    if (ninjaScroll.isNotEmpty) {
      ninjaScroll[0].play();
    }
    playerCharacter.startTurn();
    // this.currentRoom.getEnemies().forEach(enemy => {
    //   enemy.moveset.getNextMove();
    // }
    for (var enemy in currentRoom.getEnemies()) {
      enemy.initMove();
    }
    // TODO: init battle
  }
}
