import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/normality.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/classes/game_map.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/chess_pyramid.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ninja_scroll.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_snake.relic.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
import 'package:mathpunk_cardgame/classes/sellable.dart';
import 'package:mathpunk_cardgame/classes/statuses/block.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/dexterity_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/knight.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/pawn.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/precision.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/queen.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_curse.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/strength_empower.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/vulnerable.status.dart';
import 'package:mathpunk_cardgame/classes/statuses/weak.status.dart';
import 'package:mathpunk_cardgame/classes/util.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/interfaces/gamestate.interface.dart';
import 'package:mathpunk_cardgame/pools/cards.pool.dart';
import 'package:mathpunk_cardgame/pools/utils.dart';

import '../classes/deck.dart';

enum HealPlayer {
  fullHeal,
  percentageMaxHpHeal,
  percentageCurrentHpHeal,
  valueHeal
}

class GamestateController extends ChangeNotifier {
  GameTypeEnum? gameMode;
  bool inMap = false;
  List<PlayableCard> inDeck = [];
  PlayableCard? loreCard;
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
    if (selectingTarget == null) return;
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

  void deselectPlayerCharacter() {
    playerCharacter = null;
    notifyListeners();
  }

  void selectPlayerCharacter(PlayerCharacter character) {
    playerCharacter = character;
    Player player = Player();
    player.selectCharacter(character);
    notifyListeners();
  }

  void stopSelecting() {
    selectingTarget = null;
    selectingTargetCardId = null;
    notifyListeners();
  }

  void startSelecting(PlayableCard card, int cardId) {
    selectingTarget = card;
    selectingTargetCardId = cardId;
    notifyListeners();
  }

  void changeCurrentRoom(Room room) {
    if (currentRoom == null) return;
    currentRoom = room;

    notifyListeners();
  }

  void givePlayerGold(int goldValue) {
    if (playerCharacter == null) return;
    playerCharacter!.gold += goldValue;

    notifyListeners();
  }

  void healPlayer(HealPlayer healType, double? percentageValue) {
    if (playerCharacter == null) return;
    switch (healType) {
      case HealPlayer.fullHeal:
        playerCharacter!.heal(playerCharacter!.getMaxHealth());
        break;
      case HealPlayer.percentageMaxHpHeal:
        double healValue =
            (playerCharacter!.getMaxHealth() * (percentageValue ?? 1));
        playerCharacter!.heal(healValue.toInt());
        break;
      case HealPlayer.percentageCurrentHpHeal:
        double healValue =
            (playerCharacter!.getHealth() * (percentageValue ?? 1));
        playerCharacter!.heal(healValue.toInt());
        break;
      case HealPlayer.valueHeal:
        break;
    }

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
    if (playerCharacter!.mana < card.getMana()) return false;
    if (card.isCardPlayable() == false) return false;
    if (playerCharacter!
        .getDeck()
        .getHand()
        .where((x) => x.runtimeType == NormalityCard)
        .isNotEmpty) {
      if (playerCharacter!.cardsPlayedInRound >= 3) {
        return false;
      }
    }
    return true;
  }

  void buyItem(Sellable sellable) {
    if (playerCharacter == null) return;
    if (playerCharacter!.gold - sellable.getCost() < 0) {
      return;
    }

    switch (sellable.runtimeType.toString()) {
      case 'SellableRemoval':
        // sellable = SellableRemoval(cost: jsonCost, inStock: jsonInStock);
        break;
      case 'SellableCard':
        playerCharacter!.getDeck().addToDeck((sellable as SellableCard).card);
        break;
      case 'SellableRelic':
        playerCharacter!.addRelic((sellable as SellableRelic).relic);
        break;
      case 'SellableItem':
      default:
        playerCharacter!.addItem((sellable as SellableItem).item);
        break;
    }

    sellable.inStock = false;
    playerCharacter!.gold -= sellable.getCost();
    notifyListeners();
  }

  void playTheCard(PlayableCard card, List<Enemy> targets) {
    if (!_checkIfCardPlayable(card)) {
      return;
    }
    playerCharacter!.mana -= card.getMana();
    playerCharacter!.addCardsPlayedInRound(1);
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
    } else {
      selectingTarget = null;
      selectingTargetCardId = null;
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
      List<Relic> burningBlood = playerCharacter!.relics
          .where((element) => BurningBloodRelic.isRelicBurningBlood(element))
          .toList();
      if (burningBlood.isNotEmpty) {
        burningBlood[0].play();
      }
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
    _generateMap();
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

  void _generateMap() {
    gameMap = generateMap();

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

  void enterDeck({List<PlayableCard> cards = const []}) {
    if (cards.isEmpty) {
      return;
    }
    inDeck = cards;
    notifyListeners();
  }

  void exitDeck() {
    inDeck = [];
    notifyListeners();
  }

  void openLoreCard(PlayableCard card) {
    loreCard = card;
    notifyListeners();
  }

  void closeLoreCard() {
    loreCard = null;
    notifyListeners();
  }

  void visitTrader() {
    if (currentRoom == null) return;
    (currentRoom! as TradeRoom).visitedTrader = true;

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
    playerCharacter!.resetRoundStatuses();
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
      // playerCharacter!.strength = 5;
      // playerCharacter!.weak = 5;
      var deck = playerCharacter!.getDeck();
      deck.initialLoadDrawPile();

      List<Relic> chessPyramid = playerCharacter!.relics
          .where((element) => ChessPyramid.isRelicChessPyramid(element))
          .toList();
      if (chessPyramid.isNotEmpty) {
        chessPyramid[0].play();
      }

      List<Status> statuses = playerCharacter!.getStatuses();

      // if pawn status => upgrade random card from deck forever
      bool isPawnStatus = castStatusToBool(statuses, PawnStatus);
      if (isPawnStatus == true) {
        final random = Random();
        int randomElement =
            random.nextInt(playerCharacter!.getDeck().cards.length);
        while (playerCharacter!
                .getDeck()
                .cards[randomElement]
                .isCardCanBeUpgraded() ==
            false) {
          randomElement =
              random.nextInt(playerCharacter!.getDeck().cards.length);
        }
        playerCharacter!.getDeck().cards[randomElement] =
            playerCharacter!.getDeck().cards[randomElement].upgradeCard();
      }

      bool isKnightStatus = castStatusToBool(statuses, KnightStatus);
      if (isKnightStatus == true) {
        playerCharacter!.getDeck().getHand().add(ShivCard());
      }

      bool isQueenStatus = castStatusToBool(statuses, QueenStatus);
      if (isQueenStatus == true) {
        StrengthStatus ss = StrengthStatus();
        DexterityStatus ds = DexterityStatus();
        PrecisionStatus ps = PrecisionStatus();
        ss.addStack(2);
        ds.addStack(2);
        ps.addStack(15);
        playerCharacter!.addStatus(ss);
        playerCharacter!.addStatus(ds);
        playerCharacter!.addStatus(ps);
      }

      // if there are ring of snake => draw 2 cards at the start of combat
      List<Relic> ringOfSnake = playerCharacter!.relics
          .where((element) => RingOfSnake.isRelicRingOfSnake(element))
          .toList();
      if (ringOfSnake.isNotEmpty) {
        ringOfSnake[0].play();
      }
      // if there are ring of snake => draw 1 cards at the start of combat
      List<Relic> ringOfSerpent = playerCharacter!.relics
          .where((element) => RingOfSerpent.isRelicRingOfSerpent(element))
          .toList();
      if (ringOfSerpent.isNotEmpty) {
        ringOfSerpent[0].play();
      }
      // if there are ninja scroll => add 3 shivs
      List<Relic> ninjaScroll = playerCharacter!.relics
          .where((element) => NinjaScroll.isRelicNinjaScroll(element))
          .toList();
      if (ninjaScroll.isNotEmpty) {
        ninjaScroll[0].play();
      }
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
    playerCharacter!.cardsPlayedInRound = 0;
    if (playerCharacter!
        .getDeck()
        .getHand()
        .where((x) => x.runtimeType == DoubtCard)
        .isNotEmpty) {
      WeakStatus ws = WeakStatus();
      ws.addStack(1);
      playerCharacter!.addStatus(ws);
    }
    for (var enemy in currentRoom!.getEnemies()) {
      enemy.makeMove();

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
    playerCharacter!.endTurn();

    List<Status> statuses = playerCharacter!.getStatuses();

    bool isKnightStatus = castStatusToBool(statuses, KnightStatus);
    if (isKnightStatus == true) {
      playerCharacter!
          .getDeck()
          .getHand()
          .add(weightedRandomPick(poolAllCards).obj);
    }

    // if there are ring of snake => draw 1 cards at the start of round
    List<Relic> ringOfSerpent = playerCharacter!.relics
        .where((element) => RingOfSerpent.isRelicRingOfSerpent(element))
        .toList();
    if (ringOfSerpent.isNotEmpty) {
      ringOfSerpent[0].play();
    }
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
