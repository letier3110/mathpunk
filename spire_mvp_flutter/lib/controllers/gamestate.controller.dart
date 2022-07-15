import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/card/anger.card.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/reward.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';
import 'package:spire_mvp_flutter/interfaces/gamestate.interface.dart';
import 'package:spire_mvp_flutter/storage/room.storage.dart';

import '../classes/deck.dart';

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  bool inMap = false;
  bool inPause = false;
  PlayerCharacter? playerCharacter;
  List<Room> gameMap = [];
  Room? currentRoom;
  PlayableCard? selectingTarget;
  Enemy? selectedTarget;
  String? playerName;

  void setPlayerName(String playerName) {
    this.playerName = playerName;
    notifyListeners();
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

  void startSelecting(PlayableCard card) {
    selectingTarget = card;
    notifyListeners();
  }

  void selectTarget(Enemy target) {
    if (selectingTarget == null) return;
    playTheCard(selectingTarget!, [target]);
    selectingTarget = null;
    notifyListeners();
  }

  void playTheCardOnPlayer(PlayableCard card) {
    if (playerCharacter == null) return;
    if (currentRoom == null) return;
    if (playerCharacter!.mana < card.mana) return;
    playerCharacter!.mana -= card.mana;
    card.play([playerCharacter!] as List<BaseCharacter>);
    card.disposeToDiscard(
        playerCharacter!.deck.hand, playerCharacter!.deck.discardPile);
    notifyListeners();
  }

  void playTheCard(PlayableCard card, List<Enemy> targets) {
    if (playerCharacter == null) return;
    if (currentRoom == null) return;
    if (playerCharacter!.mana < card.mana) return;
    playerCharacter!.mana -= card.mana;
    card.play(targets);
    card.disposeToDiscard(
        playerCharacter!.deck.hand, playerCharacter!.deck.discardPile);

    var i = 0;
    while (i < targets.length) {
      if (targets[i].health <= 0) {
        currentRoom!.enemies.remove(targets[i]);
      }
      i++;
    }

    // if (currentRoom!.enemies.isEmpty && currentRoom!.getCanLeaveRoom()) {
    if (currentRoom!.enemies.isEmpty) {
      endTheRoom();
    }

    notifyListeners();
  }

  void endTheRoom() {
    playerCharacter!.attachDeck(Deck(playerCharacter!.deck.cards));
    enterMap();
    notifyListeners();
  }

  void startGame() {
    generateMap();
  }

  void generateMap() {
    const count = 10;
    var rng = Random();
    for (var i = 0; i < count; i++) {
      gameMap.add(EnemyRoom(roomId: '$i', roomRewards: [
        Reward(rewardCards: [AngerCard()], rewardGold: rng.nextInt(100) + 50)
      ]));
    }

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
    var rooms = gameMap;
    if (currentRoom == null) return [rooms[0]];

    var index = 0;
    var foundIndex = index;
    for (var room in rooms) {
      if (Room.isEqual(room, currentRoom!)) {
        foundIndex = index;
        break;
      }
      index++;
    }
    var nextRoomIndex = foundIndex + 1;
    if (rooms.length <= nextRoomIndex) return [];
    return [rooms[nextRoomIndex]];
  }

  void enterRoom(Room room) {
    if (playerCharacter == null) {
      return;
    }
    if (currentRoom == null) {
      currentRoom = room;
    } else if ((currentRoom != null &&
        // currentRoom!.getCanLeaveRoom() &&
        currentRoom!.enemies.isEmpty &&
        getNextAvailableRooms().contains(room))) {
      currentRoom = room;
    }

    if (currentRoom.runtimeType == EnemyRoom) {
      var deck = playerCharacter!.getDeck();
      deck.initialLoadDrawPile();
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
    }

    playerCharacter!.endTurn();
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
