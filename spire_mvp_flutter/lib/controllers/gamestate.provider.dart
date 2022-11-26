import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/sellable.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/controllers/current_room.provider.dart';
import 'package:mathpunk_cardgame/controllers/enter_enemy_room.part.provider.dart';
import 'package:mathpunk_cardgame/controllers/gamemap.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_map.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_pause.provider.dart';
import 'package:mathpunk_cardgame/controllers/is_opened_chest.provider.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/controllers/update_room.part.provider.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';
import 'package:mathpunk_cardgame/pools/cards.pool.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';

import '../classes/deck.dart';

final gamestateProvider = StateNotifierProvider<GamestateNotifier, void>((ref) {
  return GamestateNotifier(ref: ref);
});

class GamestateNotifier extends StateNotifier<void> {
  final Ref ref;

  GamestateNotifier({required this.ref}) : super([]);

  void stopPlaying() {
    ref.read(playerCharacterProvider.notifier).deselectCharacter();
    ref.read(currentRoomProvider.notifier).disposeRoom();
    ref.read(gamemapProvider.notifier).clearMap();
    ref.read(inPauseProvider.notifier).exitPause();
    ref.read(inMapProvider.notifier).exitMap();
  }

  void buyItem(Sellable sellable) {
    final playerCharacter = ref.read(playerCharacterProvider);
    if (playerCharacter == null) return;
    if (playerCharacter.gold - sellable.getCost() < 0) {
      return;
    }

    switch (sellable.runtimeType.toString()) {
      case 'SellableRemoval':
        // sellable = SellableRemoval(cost: jsonCost, inStock: jsonInStock);
        break;
      case 'SellableCard':
        playerCharacter.getDeck().addToDeck((sellable as SellableCard).card);
        break;
      case 'SellableRelic':
        playerCharacter.addRelic((sellable as SellableRelic).relic);
        break;
      case 'SellableItem':
      default:
        playerCharacter.addItem((sellable as SellableItem).item);
        break;
    }

    sellable.inStock = false;
    playerCharacter.gold -= sellable.getCost();
  }

  void playTheCard(PlayableCard card) {
    final currentRoom = ref.read(currentRoomProvider);
    final playerCharacter = ref.read(playerCharacterProvider);
    // TODO: do this flow in cardEffectProvider because of stream listener updates is related only to its own state

    // var counterStream = timedCounter(card.effects);

    // state.cardEffectSubscription = counterStream.listen((int counter) {
    //   if (card.effects[counter].isUserInteractionRequired) {
    //     state.cardEffectSubscription.pause();
    //     return;
    //   }
    //   card.effects[counter].playEffect(card, ref);
    // });

    // card.play(targets, _getPlayerCharacterNotifier());

    // if (card.step == card.maxSteps) {
    //   if (card.exhausted) {
    //     card.disposeToDiscard(
    //         playerCharacter!.deck.hand, playerCharacter!.deck.exhaustPile);
    //   } else {
    //     card.disposeToDiscard(
    //         playerCharacter!.deck.hand, playerCharacter!.deck.discardPile);
    //   }
    // }

    // if (state.selectedTarget != null) {
    //   if (state.selectingTarget!.step == state.selectingTarget!.maxSteps) {
    //     state.selectingTargetCardId = null;
    //     state.selectingTarget = null;
    //   } else {
    //     state.selectingTarget!.step = 1;
    //   }
    // } else {
    //   state.selectingTarget = null;
    //   state.selectingTargetCardId = null;
    // }

    currentRoom!.enemies =
        currentRoom.enemies.where((element) => element.health > 0).toList();

    // var i = 0;
    // while (i < targets.length) {
    //   if (targets[i].health <= 0) {
    //     state.currentRoom!.enemies.remove(targets[i]);
    //   }
    //   i++;
    // }

    if (currentRoom.enemies.isEmpty && currentRoom.getCanLeaveRoom()) {
      // if (state.currentRoom!.enemies.isEmpty) {
      // if there are burning blood => add player hp
      List<Relic> burningBlood = playerCharacter!.relics
          .where((element) => BurningBloodRelic.isRelicBurningBlood(element))
          .toList();
      if (burningBlood.isNotEmpty) {
        burningBlood[0].play();
      }
      endTheRoom();
    }
  }

  void endTheRoom() {
    final playerCharacter = ref.read(playerCharacterProvider);
    playerCharacter!.attachDeck(Deck(playerCharacter.deck.cards));
    // enterMap();
  }

  void startGame() {
    ref.read(gamemapProvider.notifier).prepareGameMap();
  }

  List<Room> getNextAvailableRooms() {
    final currentRoom = ref.read(currentRoomProvider);
    final gameMap = ref.read(gamemapProvider);
    // final gameMap = ref.read(currentRoomProvider);
    if (gameMap.isEmpty) return [];
    if (currentRoom == null) return gameMap[0];
    return currentRoom.nextRooms;
  }

  void enterRoom(Room room) {
    final currentRoom = ref.read(currentRoomProvider);
    final playerCharacter = ref.read(playerCharacterProvider);
    if (playerCharacter == null) {
      return;
    }
    playerCharacter.resetRoundStatuses();
    playerCharacter.enterRoom();
    if (currentRoom == null) {
      ref.read(updateRoomPartProvider.notifier).updateRoom(room);
    } else if ((currentRoom != null &&
        currentRoom.getCanLeaveRoom() &&
        currentRoom.enemies.isEmpty &&
        getNextAvailableRooms().contains(room))) {
      ref.read(updateRoomPartProvider.notifier).updateRoom(room);
    }
    ref.read(isOpenedChestProvider.notifier).stopSelectingChest();
    if (currentRoom.runtimeType == EnemyRoom) {
      ref.read(eneterEnemyRoomPartProvider.notifier).enemyRoomEnter();
    }
  }

  void nextTurn() {
    final currentRoom = ref.read(currentRoomProvider);
    final playerCharacter = ref.read(playerCharacterProvider);

    if (playerCharacter == null) {
      return;
    }
    if (currentRoom == null) {
      return;
    }
    playerCharacter.cardsPlayedInRound = 0;
    if (playerCharacter
        .getDeck()
        .getHand()
        .where((x) => x.runtimeType == DoubtCard)
        .isNotEmpty) {
      WeakStatus ws = WeakStatus();
      ws.addStack(1);
      playerCharacter.addStatus(ws);
    }
    for (var enemy in currentRoom.getEnemies()) {
      enemy.makeMove(_getPlayerCharacterNotifier());

      BlockStatus block = BlockStatus();
      enemy.setStatus(block);

      List<Status> statuses = enemy.getStatuses();
      int weak = castStatusToInt(statuses, WeakStatus);
      int vulnerable = castStatusToInt(statuses, VulnerableStatus);

      if (vulnerable > 0) {
        VulnerableStatus vs = VulnerableStatus();
        vs.addStack(-1);
        enemy.addStatus(vs);
      }
      if (weak > 0) {
        WeakStatus ws = WeakStatus();
        ws.addStack(-1);
        enemy.addStatus(ws);
      }
      int strengthCurse = castStatusToInt(statuses, StrengthCurseStatus);
      int strengthEmpower = castStatusToInt(statuses, StrengthEmpowerStatus);
      StrengthStatus ss = StrengthStatus();
      ss.addStack(-strengthCurse.toDouble());
      ss.addStack(strengthEmpower.toDouble());
      enemy.addStatus(ss);

      int dexterityCurse = castStatusToInt(statuses, DexterityCurseStatus);
      int dexterityEmpower = castStatusToInt(statuses, DexterityEmpowerStatus);
      DexterityStatus ds = DexterityStatus();
      ds.addStack(-dexterityCurse.toDouble());
      ds.addStack(dexterityEmpower.toDouble());
      enemy.addStatus(ds);

      StrengthCurseStatus scs = StrengthCurseStatus();
      enemy.setStatus(scs);

      DexterityCurseStatus dcs = DexterityCurseStatus();
      enemy.setStatus(dcs);

      StrengthEmpowerStatus ses = StrengthEmpowerStatus();
      enemy.setStatus(ses);

      DexterityEmpowerStatus des = DexterityEmpowerStatus();
      enemy.setStatus(des);
    }
    playerCharacter.endTurn();

    List<Status> statuses = playerCharacter.getStatuses();

    bool isKnightStatus = castStatusToBool(statuses, KnightStatus);
    if (isKnightStatus == true) {
      playerCharacter
          .getDeck()
          .getHand()
          .add(weightedRandomPick(poolAllCards).obj);
    }

    // if there are ring of snake => draw 1 cards at the start of round
    List<Relic> ringOfSerpent = playerCharacter.relics
        .where((element) => RingOfSerpent.isRelicRingOfSerpent(element))
        .toList();
    if (ringOfSerpent.isNotEmpty) {
      ringOfSerpent[0].play();
    }
  }

  PlayerCharacterNotifier _getPlayerCharacterNotifier() {
    return ref.read(playerCharacterProvider.notifier);
  }
}
