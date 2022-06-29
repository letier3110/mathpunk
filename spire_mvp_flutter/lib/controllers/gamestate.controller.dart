import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/enigma_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/mage_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/rogue_character.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/warrior_character.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/classes/room/room.dart';
import 'package:spire_mvp_flutter/enums/game_type.enum.dart';

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  bool inMap = false;
  PlayerCharacter? playerCharacter;
  Player? player;
  List<Room> gameMap = [];
  Room? currentRoom;

  final List<PlayerCharacter> playableCharacters = [
    Warrior(),
    Mage(),
    Rogue(),
    Enigma()
  ];

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
    notifyListeners();
  }

  void selectPlayerCharacter(PlayerCharacter character) {
    playerCharacter = character;
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
      notifyListeners();
      return;
    }
    if (currentRoom!.getCanLeaveRoom() &&
        getNextAvailableRooms().contains(currentRoom)) {
      currentRoom = room;
      if (currentRoom.runtimeType == EnemyRoom) {
        playerCharacter!.getDeck().initialLoadDrawPile();
        // this.currentRoom.getEnemies().forEach(enemy => {
        //   enemy.moveset.getNextMove();
        // }
        // TODO: init battle
      }
    }
    notifyListeners();
  }

  getCurrentRoom() {
    return currentRoom;
  }
}
