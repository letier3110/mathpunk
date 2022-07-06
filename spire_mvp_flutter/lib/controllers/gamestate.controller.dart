import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/enemy/enemy.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  bool inMap = false;
  bool inPause = false;
  PlayerCharacter? playerCharacter;
  final Player player = Player();
  List<Room> gameMap = [];
  Room? currentRoom;
  bool selectingTarget = false;
  Enemy? selectedTarget;

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
    notifyListeners();
  }

  void startSelecting() {
    selectingTarget = true;
    notifyListeners();
  }

  void selectTarget(Enemy target, Function callback) {
    selectingTarget = false;
    callback(target);
    notifyListeners();
  }

  void playTheCard(PlayableCard card, List<Enemy> targets) {
    if (playerCharacter == null) return;
    if (playerCharacter!.mana < card.mana) return;
    playerCharacter!.mana -= card.mana;
    card.play(targets);
    card.disposeToDiscard(
        playerCharacter!.deck.hand, playerCharacter!.deck.discardPile);

    notifyListeners();
  }

  void startGame() {
    generateMap();
  }

  void generateMap() {
    const count = 10;
    for (var i = 0; i < count; i++) {
      gameMap.add(EnemyRoom(roomId: '$i'));
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
        currentRoom!.getCanLeaveRoom() &&
        getNextAvailableRooms().contains(currentRoom))) {
      currentRoom = room;
    }

    if (currentRoom.runtimeType == EnemyRoom) {
      var deck = playerCharacter!.getDeck();
      deck.initialLoadDrawPile();
      playerCharacter!.startTurn();
      // this.currentRoom.getEnemies().forEach(enemy => {
      //   enemy.moveset.getNextMove();
      // }
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
}
