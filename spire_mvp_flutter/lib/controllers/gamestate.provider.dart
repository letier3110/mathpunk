import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/normality.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/enemy/enemy.dart';
import 'package:mathpunk_cardgame/classes/game_map.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/classes/relic/burning_blood.relic.dart';
import 'package:mathpunk_cardgame/classes/relic/relic.dart';
import 'package:mathpunk_cardgame/classes/relic/ring_of_serpent.relic.dart';
import 'package:mathpunk_cardgame/classes/reward.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/classes/room/room.dart';
import 'package:mathpunk_cardgame/classes/room/trade_room.dart';
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
import 'package:mathpunk_cardgame/controllers/gamestate/enemy-room.gamestate.util.dart';
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

final gamestateProvider =
    StateNotifierProvider<GamestateNotifier, GamestateNotifierInterface>((ref) {
  return GamestateNotifier();
});

class GamestateNotifierInterface {
  GamestateNotifierInterface(
      {this.gameMode,
      this.inMap = false,
      this.inDeck = const [],
      this.loreCard,
      this.inPause = false,
      this.playerCharacter,
      this.gameMap = const [],
      this.visitedRooms = const [],
      this.currentRoom,
      this.selectedTarget,
      this.selectingCardReward = const [],
      this.isOpenedChest,
      this.selectingTargetCardId,
      this.selectingTarget,
      this.playerName});

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
  Reward? isOpenedChest;
  int? selectingTargetCardId;
  Enemy? selectedTarget;
  String? playerName;
}

class GamestateNotifier extends StateNotifier<GamestateNotifierInterface> {
  GamestateNotifier() : super(GamestateNotifierInterface());

  void setPlayerName(String playerName) {
    state.playerName = playerName;
  }

  void setSelectedCards(List<PlayableCard> selectedCards) {
    if (state.selectingTarget == null) return;
    state.selectingTarget!.setSelectedCards(selectedCards);
  }

  void exitGameMode() {
    state.gameMode = null;
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    state.gameMode = newGameMode;
  }

  void stopPlaying() {
    state.playerCharacter = null;
    state.currentRoom = null;
    state.gameMap = [];
    state.inPause = false;
    state.inMap = false;
  }

  void deselectPlayerCharacter() {
    state.playerCharacter = null;
  }

  void selectPlayerCharacter(PlayerCharacter character) {
    state.playerCharacter = character;
    Player player = Player();
    player.selectCharacter(character);
  }

  void stopSelecting() {
    state.selectingTarget = null;
    state.selectingTargetCardId = null;
  }

  void startSelecting(PlayableCard card, int cardId) {
    state.selectingTarget = card;
    state.selectingTargetCardId = cardId;
  }

  void changeCurrentRoom(Room room) {
    if (state.currentRoom == null) return;
    state.currentRoom = room;
    if (state.currentRoom.runtimeType == EnemyRoom) {
      enemyRoomEnter(
          currentRoom: state.currentRoom!,
          playerCharacter: state.playerCharacter!);
    }
  }

  void givePlayerGold(int goldValue) {
    if (state.playerCharacter == null) return;
    state.playerCharacter!.gold += goldValue;
  }

  void healPlayer(HealPlayer healType, double? percentageValue) {
    if (state.playerCharacter == null) return;
    switch (healType) {
      case HealPlayer.fullHeal:
        state.playerCharacter!.heal(state.playerCharacter!.getMaxHealth());
        break;
      case HealPlayer.percentageMaxHpHeal:
        double healValue =
            (state.playerCharacter!.getMaxHealth() * (percentageValue ?? 1));
        state.playerCharacter!.heal(healValue.toInt());
        break;
      case HealPlayer.percentageCurrentHpHeal:
        double healValue =
            (state.playerCharacter!.getHealth() * (percentageValue ?? 1));
        state.playerCharacter!.heal(healValue.toInt());
        break;
      case HealPlayer.valueHeal:
        break;
    }
  }

  void selectTarget(Enemy target) {
    if (state.selectingTarget == null) return;
    playTheCard(state.selectingTarget!, [target]);
  }

  bool _checkIfCardPlayable(PlayableCard card) {
    if (state.playerCharacter == null) return false;
    if (state.currentRoom == null) return false;
    if (state.playerCharacter!.mana < card.getMana()) return false;
    if (card.isCardPlayable() == false) return false;
    if (state.playerCharacter!
        .getDeck()
        .getHand()
        .where((x) => x.runtimeType == NormalityCard)
        .isNotEmpty) {
      if (state.playerCharacter!.cardsPlayedInRound >= 3) {
        return false;
      }
    }
    return true;
  }

  void buyItem(Sellable sellable) {
    if (state.playerCharacter == null) return;
    if (state.playerCharacter!.gold - sellable.getCost() < 0) {
      return;
    }

    switch (sellable.runtimeType.toString()) {
      case 'SellableRemoval':
        // sellable = SellableRemoval(cost: jsonCost, inStock: jsonInStock);
        break;
      case 'SellableCard':
        state.playerCharacter!
            .getDeck()
            .addToDeck((sellable as SellableCard).card);
        break;
      case 'SellableRelic':
        state.playerCharacter!.addRelic((sellable as SellableRelic).relic);
        break;
      case 'SellableItem':
      default:
        state.playerCharacter!.addItem((sellable as SellableItem).item);
        break;
    }

    sellable.inStock = false;
    state.playerCharacter!.gold -= sellable.getCost();
  }

  void playTheCard(PlayableCard card, List<Enemy> targets) {
    if (!_checkIfCardPlayable(card)) {
      return;
    }
    state.playerCharacter!.mana -= card.getMana();
    state.playerCharacter!.addCardsPlayedInRound(1);
    card.play(targets);

    if (card.step == card.maxSteps) {
      if (card.exhausted) {
        card.disposeToDiscard(state.playerCharacter!.deck.hand,
            state.playerCharacter!.deck.exhaustPile);
      } else {
        card.disposeToDiscard(state.playerCharacter!.deck.hand,
            state.playerCharacter!.deck.discardPile);
      }
    }

    if (state.selectedTarget != null) {
      if (state.selectingTarget!.step == state.selectingTarget!.maxSteps) {
        state.selectingTargetCardId = null;
        state.selectingTarget = null;
      } else {
        state.selectingTarget!.step = 1;
      }
    } else {
      state.selectingTarget = null;
      state.selectingTargetCardId = null;
    }

    var i = 0;
    while (i < targets.length) {
      if (targets[i].health <= 0) {
        state.currentRoom!.enemies.remove(targets[i]);
      }
      i++;
    }

    if (state.currentRoom!.enemies.isEmpty &&
        state.currentRoom!.getCanLeaveRoom()) {
      // if (state.currentRoom!.enemies.isEmpty) {
      // if there are burning blood => add player hp
      List<Relic> burningBlood = state.playerCharacter!.relics
          .where((element) => BurningBloodRelic.isRelicBurningBlood(element))
          .toList();
      if (burningBlood.isNotEmpty) {
        burningBlood[0].play();
      }
      endTheRoom();
    }
  }

  void endTheRoom() {
    state.playerCharacter!.attachDeck(Deck(state.playerCharacter!.deck.cards));
    // enterMap();
  }

  void startGame() {
    _generateMap();
  }

  void selectChest(Reward reward) {
    if (state.playerCharacter == null) {
      state.playerCharacter!.resetRoundStatuses();
    }
    state.isOpenedChest = reward;
  }

  void stopSelectingChest() {
    state.isOpenedChest = null;
  }

  void selectCardReward(List<PlayableCard> cards) {
    state.selectingCardReward = cards;
  }

  void stopSelectingCardReward() {
    state.selectingCardReward = [];

    checkIfEveryRewardGet();
  }

  void pickCardReward(List<PlayableCard> cards, PlayableCard pickedCard) {
    if (state.currentRoom == null) return;
    if (state.playerCharacter == null) return;

    try {
      state.playerCharacter!.deck.addToDeck(pickedCard);
      int i = state.currentRoom!.rewards.indexWhere((element) =>
          element.cards.every((element) => cards.contains(element)));
      state.currentRoom!.rewards[i].cards = [];
    } catch (e) {}

    stopSelectingCardReward();
  }

  void pickReward(int rewardIndex, String fieldType) {
    if (state.currentRoom == null) return;
    if (state.playerCharacter == null) return;
    // List<Status> statuses = state.playerCharacter!.getStatuses();
    switch (fieldType) {
      case 'gold':
        int goldReward = state.currentRoom!.rewards[rewardIndex].gold ?? 0;
        // bool isKingStatus = castStatusToBool(statuses, KingStatus);
        // if (isKingStatus) {
        //   goldReward = goldReward * 2;
        // }
        state.playerCharacter!.gold += goldReward;
        state.currentRoom!.rewards[rewardIndex].gold = null;
        break;
      case 'item':
        if (state.currentRoom!.rewards[rewardIndex].item != null) {
          state.playerCharacter!.items
              .add(state.currentRoom!.rewards[rewardIndex].item!);
        }
        state.currentRoom!.rewards[rewardIndex].item = null;
        break;
      case 'relic':
        if (state.currentRoom!.rewards[rewardIndex].relic != null) {
          state.playerCharacter!.relics
              .add(state.currentRoom!.rewards[rewardIndex].relic!);
        }
        state.currentRoom!.rewards[rewardIndex].relic = null;
        break;
      // case 'cards':
      //   if (selectedCard != null) {
      //     playerCharacter!.deck.addToDeck(selectedCard);
      //   }
      //   currentRoom!.rewards[rewardIndex].cards = [];
      //   break;
    }

    checkIfEveryRewardGet();
  }

  void checkIfEveryRewardGet() {
    if (state.currentRoom != null) {
      if (state.currentRoom!.rewards.every((element) =>
          element.cards.isEmpty &&
          element.gold == null &&
          element.item == null &&
          element.relic == null)) {
        enterMap();
      }
    }
  }

  void _generateMap() {
    state.gameMap = generateMap();
  }

  void enterPause() {
    state.inPause = true;
  }

  void exitPause() {
    state.inPause = false;
  }

  void enterMap() {
    state.inMap = true;
  }

  void exitMap() {
    state.inMap = false;
  }

  void enterDeck({List<PlayableCard> cards = const []}) {
    if (cards.isEmpty) {
      return;
    }
    state.inDeck = cards;
  }

  void exitDeck() {
    state.inDeck = [];
  }

  void openLoreCard(PlayableCard card) {
    state.loreCard = card;
  }

  void closeLoreCard() {
    state.loreCard = null;
  }

  void visitTrader() {
    if (state.currentRoom == null) return;
    (state.currentRoom! as TradeRoom).visitedTrader = true;
  }

  List<Room> getNextAvailableRooms() {
    if (state.gameMap.isEmpty) return [];
    if (state.currentRoom == null) return state.gameMap[0];
    return state.currentRoom!.nextRooms;
  }

  void enterRoom(Room room) {
    if (state.playerCharacter == null) {
      return;
    }
    state.playerCharacter!.resetRoundStatuses();
    state.playerCharacter!.enterRoom();
    if (state.currentRoom == null) {
      state.currentRoom = room;
      state.visitedRooms.add(room);
    } else if ((state.currentRoom != null &&
        state.currentRoom!.getCanLeaveRoom() &&
        // state.currentRoom!.enemies.isEmpty &&
        getNextAvailableRooms().contains(room))) {
      state.currentRoom = room;
      state.visitedRooms.add(room);
    }

    state.isOpenedChest = null;
    if (state.currentRoom.runtimeType == EnemyRoom) {
      enemyRoomEnter(
          currentRoom: state.currentRoom!,
          playerCharacter: state.playerCharacter!);
    }
  }

  void nextTurn() {
    if (state.playerCharacter == null) {
      return;
    }
    if (state.currentRoom == null) {
      return;
    }
    state.playerCharacter!.cardsPlayedInRound = 0;
    if (state.playerCharacter!
        .getDeck()
        .getHand()
        .where((x) => x.runtimeType == DoubtCard)
        .isNotEmpty) {
      WeakStatus ws = WeakStatus();
      ws.addStack(1);
      state.playerCharacter!.addStatus(ws);
    }
    for (var enemy in state.currentRoom!.getEnemies()) {
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
    state.playerCharacter!.endTurn();

    List<Status> statuses = state.playerCharacter!.getStatuses();

    bool isKnightStatus = castStatusToBool(statuses, KnightStatus);
    if (isKnightStatus == true) {
      state.playerCharacter!
          .getDeck()
          .getHand()
          .add(weightedRandomPick(poolAllCards).obj);
    }

    // if there are ring of snake => draw 1 cards at the start of round
    List<Relic> ringOfSerpent = state.playerCharacter!.relics
        .where((element) => RingOfSerpent.isRelicRingOfSerpent(element))
        .toList();
    if (ringOfSerpent.isNotEmpty) {
      ringOfSerpent[0].play();
    }
  }

  getCurrentRoom() => state.currentRoom;

  void fromJson(GameStateInterface savedInfo) {
    state.gameMode = savedInfo.gameMode;
    state.inMap = savedInfo.inMap;
    state.inPause = savedInfo.inPause;
    state.playerCharacter = savedInfo.playerCharacter;
    state.gameMap = savedInfo.gameMap;
    state.currentRoom = savedInfo.currentRoom;
    Player player = Player();
    if (savedInfo.playerCharacter != null) {
      player.selectCharacter(savedInfo.playerCharacter!);
    }
  }

  Map toJson() {
    return GameStateInterface(
            gameMode: state.gameMode,
            inMap: state.inMap,
            inPause: state.inPause,
            playerCharacter: state.playerCharacter,
            gameMap: state.gameMap,
            currentRoom: state.currentRoom,
            playerName: state.playerName ?? 'autosave')
        .toJson();
  }
}
