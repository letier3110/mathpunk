import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/card/cards_implementation.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy_ogre.dart';
import 'package:spire_mvp_flutter/classes/items/fear.potion.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/relic/burning_blood.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_serpent.relic.dart';
import 'package:spire_mvp_flutter/classes/relic/ring_of_snake.relic.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';
import 'package:spire_mvp_flutter/interfaces/gamestate.interface.dart';

import '../classes/deck.dart';
import '../utils/room.util.dart';

const int levelsRandomLength = 7;
const int levelsFixedLength = 7;
const int roomsCountPerSliceRandom = 5;
const int roomsCountPerSliceFixed = 4;
const int nextRoomsConnectionsRandom = 2;
const int nextRoomsConnectionsFixed = 1;
const int roomConnectionProbability = 50;

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  bool inMap = false;
  bool inPause = false;
  PlayerCharacter? playerCharacter;
  List<List<Room>> gameMap = [];
  List<Room> visitedRooms = [];
  Room? currentRoom;
  PlayableCard? selectingTarget;
  List<PlayableCard> selectingCardReward = [];
  int? selectingTargetCardId;
  Enemy? selectedTarget;
  String? playerName;

  void setPlayerName(String playerName) {
    this.playerName = playerName;
    notifyListeners();
  }

  void setSelectedCards(List<PlayableCard> selectedCards) {
    if (selectedTarget == null) return;
    selectingTarget!.setSelectedCards(selectedCards);
  }

  void exitGameMode() {
    gameMode = null;
    notifyListeners();
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    gameMode = newGameMode;
    notifyListeners();
  }

  void stopPlaying() {
    playerCharacter = null;
    currentRoom = null;
    gameMap = [];
    inPause = false;
    inMap = false;
    notifyListeners();
  }

  void selectPlayerCharacter(PlayerCharacter character) {
    playerCharacter = character;
    Player player = Player();
    player.selectCharacter(character);
    notifyListeners();
  }

  void startSelecting(PlayableCard card, int cardId) {
    selectingTarget = card;
    selectingTargetCardId = cardId;
    notifyListeners();
  }

  void selectTarget(Enemy target) {
    if (selectingTarget == null) return;
    playTheCard(selectingTarget!, [target]);
    notifyListeners();
  }

  bool _checkIfCardPlayable(PlayableCard card) {
    if (playerCharacter == null) return false;
    if (currentRoom == null) return false;
    if (playerCharacter!.mana < card.mana) return false;
    if (card.isCardPlayable() == false) return false;
    return true;
  }

  void playTheCard(PlayableCard card, List<Enemy> targets) {
    if (!_checkIfCardPlayable(card)) {
      return;
    }
    playerCharacter!.mana -= card.mana;
    card.play(targets);
    if (card.step == card.maxSteps) {
      if (card.exhausted) {
        card.disposeToDiscard(
            playerCharacter!.deck.hand, playerCharacter!.deck.exhaustPile);
      } else {
        card.disposeToDiscard(
            playerCharacter!.deck.hand, playerCharacter!.deck.discardPile);
      }
    }

    if (selectedTarget != null) {
      if (selectingTarget!.step == selectingTarget!.maxSteps) {
        selectingTargetCardId = null;
        selectingTarget = null;
      } else {
        selectingTarget!.step = 1;
      }
    }

    var i = 0;
    while (i < targets.length) {
      if (targets[i].health <= 0) {
        currentRoom!.enemies.remove(targets[i]);
      }
      i++;
    }

    if (currentRoom!.enemies.isEmpty && currentRoom!.getCanLeaveRoom()) {
      // if (currentRoom!.enemies.isEmpty) {
      // if there are burning blood => add player hp
      try {
        playerCharacter!.relics
            .firstWhere(
                (element) => BurningBloodRelic.isRelicBurningBlood(element))
            .play();
      } catch (e) {}
      endTheRoom();
    }

    notifyListeners();
  }

  void endTheRoom() {
    playerCharacter!.attachDeck(Deck(playerCharacter!.deck.cards));
    // enterMap();
    notifyListeners();
  }

  void startGame() {
    generateMap();
  }

  void selectCardReward(List<PlayableCard> cards) {
    selectingCardReward = cards;

    notifyListeners();
  }

  void stopSelectingCardReward() {
    selectingCardReward = [];

    checkIfEveryRewardGet();

    notifyListeners();
  }

  void pickCardReward(List<PlayableCard> cards, PlayableCard pickedCard) {
    if (currentRoom == null) return;
    if (playerCharacter == null) return;

    try {
      playerCharacter!.deck.addToDeck(pickedCard);
      int i = currentRoom!.rewards.indexWhere((element) =>
          element.cards.every((element) => cards.contains(element)));
      currentRoom!.rewards[i].cards = [];
    } catch (e) {}

    stopSelectingCardReward();
  }

  void pickReward(int rewardIndex, String fieldType) {
    if (currentRoom == null) return;
    if (playerCharacter == null) return;
    switch (fieldType) {
      case 'gold':
        playerCharacter!.gold += currentRoom!.rewards[rewardIndex].gold ?? 0;
        currentRoom!.rewards[rewardIndex].gold = null;
        break;
      case 'item':
        if (currentRoom!.rewards[rewardIndex].item != null) {
          playerCharacter!.items.add(currentRoom!.rewards[rewardIndex].item!);
        }
        currentRoom!.rewards[rewardIndex].item = null;
        break;
      case 'relic':
        if (currentRoom!.rewards[rewardIndex].relic != null) {
          playerCharacter!.relics.add(currentRoom!.rewards[rewardIndex].relic!);
        }
        currentRoom!.rewards[rewardIndex].relic = null;
        break;
      // case 'cards':
      //   if (selectedCard != null) {
      //     playerCharacter!.deck.addToDeck(selectedCard);
      //   }
      //   currentRoom!.rewards[rewardIndex].cards = [];
      //   break;
    }

    checkIfEveryRewardGet();

    notifyListeners();
  }

  void checkIfEveryRewardGet() {
    if (currentRoom != null) {
      if (currentRoom!.rewards.every((element) =>
          element.cards.isEmpty &&
          element.gold == null &&
          element.item == null &&
          element.relic == null)) {
        enterMap();
      }
    }
  }

  // 534421

  void generateMap() {
    var rng = Random();
    var maxLevels = rng.nextInt(levelsRandomLength) + levelsFixedLength;
    List<Room> prevSlice = [];
    for (var i = 0; i < maxLevels; i++) {
      var roomsCount =
          rng.nextInt(roomsCountPerSliceRandom) + roomsCountPerSliceFixed;
      List<Room> roomSlice = [];
      for (var j = 0; j < roomsCount; j++) {
        roomSlice.add(EnemyRoom(roomId: '$j $i', roomRewards: [
          Reward(
              rewardCards: [angerCard, strikeCard, bashCard],
              rewardItem: FearPotion(),
              rewardRelic: BurningBloodRelic(),
              rewardGold: rng.nextInt(100) + 50)
        ]));
      }
      if (prevSlice.isNotEmpty) {
        for (var room in prevSlice) {
          var roomConnections = 0;
          var maxRoomConnetions = rng.nextInt(nextRoomsConnectionsRandom) +
              nextRoomsConnectionsFixed;
          for (var j = 0; j < roomsCount; j++) {
            if (roomConnections == maxRoomConnetions) continue;
            if (getProbability(roomConnectionProbability)) {
              room.nextRooms.add(roomSlice[j]);
              roomConnections++;
            }
          }
        }
      }
      prevSlice = roomSlice;
      gameMap.add(roomSlice);
    }
    var bossRoom = EnemyRoom(roomId: 'boss1', roomRewards: [
      Reward(
          rewardCards: [angerCard, strikeCard, bashCard],
          rewardRelic: BurningBloodRelic(),
          rewardGold: rng.nextInt(100) + 50)
    ], roomEnemies: [
      EnemyOgre()
    ]);
    for (var i = 0; i < gameMap.last.length; i++) {
      gameMap.last[i].nextRooms = [bossRoom];
    }
    gameMap.add([bossRoom]);

    notifyListeners();
  }

  void enterPause() {
    inPause = true;
    notifyListeners();
  }

  void exitPause() {
    inPause = false;
    notifyListeners();
  }

  void enterMap() {
    inMap = true;
    notifyListeners();
  }

  void exitMap() {
    inMap = false;
    notifyListeners();
  }

  List<Room> getNextAvailableRooms() {
    if (gameMap.isEmpty) return [];
    if (currentRoom == null) return gameMap[0];
    return currentRoom!.nextRooms;
  }

  void enterRoom(Room room) {
    if (playerCharacter == null) {
      return;
    }
    if (currentRoom == null) {
      currentRoom = room;
      visitedRooms.add(room);
    } else if ((currentRoom != null &&
        currentRoom!.getCanLeaveRoom() &&
        // currentRoom!.enemies.isEmpty &&
        getNextAvailableRooms().contains(room))) {
      currentRoom = room;
      visitedRooms.add(room);
    }

    if (currentRoom.runtimeType == EnemyRoom) {
      var deck = playerCharacter!.getDeck();
      deck.initialLoadDrawPile();
      // if there are ring of snake => draw 2 cards at the start of combat
      try {
        playerCharacter!.relics
            .firstWhere((element) => RingOfSnake.isRelicRingOfSnake(element))
            .play();
      } catch (e) {}
      // if there are ring of snake => draw 1 cards at the start of combat
      try {
        playerCharacter!.relics
            .firstWhere(
                (element) => RingOfSerpent.isRelicRingOfSerpent(element))
            .play();
      } catch (e) {}
      playerCharacter!.startTurn();
      // this.currentRoom.getEnemies().forEach(enemy => {
      //   enemy.moveset.getNextMove();
      // }
      for (var enemy in currentRoom!.getEnemies()) {
        enemy.initMove();
      }
      // TODO: init battle
    }
    notifyListeners();
  }

  void nextTurn() {
    if (playerCharacter == null) {
      return;
    }
    if (currentRoom == null) {
      return;
    }
    for (var enemy in currentRoom!.getEnemies()) {
      enemy.makeMove();
      enemy.block = 0;
      if (enemy.vulnerable > 0) {
        enemy.vulnerable -= 1;
      }
      if (enemy.weak > 0) {
        enemy.weak -= 1;
      }
      enemy.strength -= enemy.strengthCurse;
      enemy.strengthCurse = 0;
      enemy.strength += enemy.strengthEmpower;
    }
    playerCharacter!.endTurn();
    // if there are ring of snake => draw 1 cards at the start of round
    try {
      playerCharacter!.relics
          .firstWhere((element) => RingOfSerpent.isRelicRingOfSerpent(element))
          .play();
    } catch (e) {}
    notifyListeners();
  }

  getCurrentRoom() {
    return currentRoom;
  }

  void fromJson(GameStateInterface savedInfo) {
    gameMode = savedInfo.gameMode;
    inMap = savedInfo.inMap;
    inPause = savedInfo.inPause;
    playerCharacter = savedInfo.playerCharacter;
    gameMap = savedInfo.gameMap;
    currentRoom = savedInfo.currentRoom;
    Player player = Player();
    if (savedInfo.playerCharacter != null) {
      player.selectCharacter(savedInfo.playerCharacter!);
    }
    notifyListeners();
  }

  Map toJson() {
    return GameStateInterface(
            gameMode: gameMode,
            inMap: inMap,
            inPause: inPause,
            playerCharacter: playerCharacter,
            gameMap: gameMap,
            currentRoom: currentRoom,
            playerName: playerName ?? 'autosave')
        .toJson();
  }
}
