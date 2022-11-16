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
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/enums/game_type.enum.dart';
import 'package:mathpunk_cardgame/interfaces/gamestate.interface.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';
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
  final playerCharacter = ref.watch(playerCharacterProvider);
  return GamestateNotifier(ref: ref, playerCharacter: playerCharacter);
});

class GamestateNotifierInterface {
  GamestateNotifierInterface(
      {this.gameMode,
      this.inMap = false,
      this.inDeck = const [],
      this.loreCard,
      this.inPause = false,
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
  List<List<Room>> gameMap = [];
  List<Room> visitedRooms = [];
  Room? currentRoom;
  PlayableCard? selectingTarget;
  List<PlayableCard> selectingCardReward = [];
  Reward? isOpenedChest;
  int? selectingTargetCardId;
  Enemy? selectedTarget;
  String? playerName;

  void updateRoom(Room room) {
    currentRoom = room;
    visitedRooms = [...visitedRooms, room];
  }
}

class GamestateNotifier extends StateNotifier<GamestateNotifierInterface> {
  PlayerCharacter? playerCharacter;
  final Ref ref;

  GamestateNotifier({this.playerCharacter, required this.ref})
      : super(GamestateNotifierInterface());

  void updateState() {
    state = GamestateNotifierInterface(
      gameMode: state.gameMode,
      inMap: state.inMap,
      inDeck: state.inDeck,
      loreCard: state.loreCard,
      inPause: state.inPause,
      gameMap: state.gameMap,
      visitedRooms: state.visitedRooms,
      currentRoom: state.currentRoom,
      selectedTarget: state.selectedTarget,
      selectingCardReward: state.selectingCardReward,
      isOpenedChest: state.isOpenedChest,
      selectingTargetCardId: state.selectingTargetCardId,
      selectingTarget: state.selectingTarget,
      playerName: state.playerName,
    );
  }

  void setPlayerName(String playerName) {
    state.playerName = playerName;
    updateState();
  }

  void exitGameMode() {
    state.gameMode = null;
    updateState();
  }

  void changeGameMode(GameTypeEnum newGameMode) {
    state.gameMode = newGameMode;
    updateState();
  }

  void stopPlaying() {
    playerCharacter = null;
    state.currentRoom = null;
    state.gameMap = [];
    state.inPause = false;
    state.inMap = false;
    updateState();
  }

  void stopSelecting() {
    state.selectingTarget = null;
    state.selectingTargetCardId = null;
    updateState();
  }

  void startSelecting(PlayableCard card, int cardId) {
    state.selectingTarget = card;
    state.selectingTargetCardId = cardId;
    updateState();
  }

  void changeCurrentRoom(Room room) {
    if (state.currentRoom == null) return;
    state.currentRoom = room;
    if (state.currentRoom.runtimeType == EnemyRoom) {
      enemyRoomEnter(
          currentRoom: state.currentRoom!, playerCharacter: playerCharacter!);
    }
    updateState();
  }

  void givePlayerGold(int goldValue) {
    if (playerCharacter == null) return;
    _getPlayerCharacterNotifier().addGold(goldValue);
  }

  void healPlayer(HealPlayer healType, double? percentageValue) {
    if (playerCharacter == null) return;
    switch (healType) {
      case HealPlayer.fullHeal:
        ref
            .read(playerCharacterProvider.notifier)
            .heal(playerCharacter!.getMaxHealth());
        break;
      case HealPlayer.percentageMaxHpHeal:
        double healValue =
            (playerCharacter!.getMaxHealth() * (percentageValue ?? 1));
        _getPlayerCharacterNotifier().heal(healValue.toInt());
        break;
      case HealPlayer.percentageCurrentHpHeal:
        double healValue =
            (playerCharacter!.getHealth() * (percentageValue ?? 1));
        _getPlayerCharacterNotifier().heal(healValue.toInt());
        break;
      case HealPlayer.valueHeal:
        break;
    }
  }

  void selectTarget(Enemy target) {
    if (state.selectingTarget == null) return;
    playTheCard(state.selectingTarget!, [target]);
    updateState();
  }

  bool _checkIfCardPlayable(PlayableCard card) {
    if (playerCharacter == null) return false;
    if (state.currentRoom == null) return false;
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
  }

  void playTheCard(PlayableCard card) {
    if (!_checkIfCardPlayable(card)) {
      return;
    }
    playerCharacter!.mana -= card.getMana();
    playerCharacter!.addCardsPlayedInRound(1);
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
      List<Relic> burningBlood = playerCharacter!.relics
          .where((element) => BurningBloodRelic.isRelicBurningBlood(element))
          .toList();
      if (burningBlood.isNotEmpty) {
        burningBlood[0].play();
      }
      endTheRoom();
    }
    updateState();
  }

  void endTheRoom() {
    playerCharacter!.attachDeck(Deck(playerCharacter!.deck.cards));
    // enterMap();
    updateState();
  }

  void startGame() {
    _generateMap();
  }

  void selectChest(Reward reward) {
    if (playerCharacter == null) {
      playerCharacter!.resetRoundStatuses();
    }
    state.isOpenedChest = reward;
    updateState();
  }

  void stopSelectingChest() {
    state.isOpenedChest = null;
    updateState();
  }

  void selectCardReward(List<PlayableCard> cards) {
    state.selectingCardReward = cards;
    updateState();
  }

  void stopSelectingCardReward() {
    state.selectingCardReward = [];

    checkIfEveryRewardGet();
  }

  void pickCardReward(List<PlayableCard> cards, PlayableCard pickedCard) {
    if (state.currentRoom == null) return;
    if (playerCharacter == null) return;

    try {
      playerCharacter!.deck.addToDeck(pickedCard);
      int i = state.currentRoom!.rewards.indexWhere((element) =>
          element.cards.every((element) => cards.contains(element)));
      state.currentRoom!.rewards[i].cards = [];
    } catch (e) {}

    stopSelectingCardReward();
  }

  void pickReward(int rewardIndex, String fieldType) {
    if (state.currentRoom == null) return;
    if (playerCharacter == null) return;
    // List<Status> statuses = playerCharacter!.getStatuses();
    switch (fieldType) {
      case 'gold':
        int goldReward = state.currentRoom!.rewards[rewardIndex].gold ?? 0;
        // bool isKingStatus = castStatusToBool(statuses, KingStatus);
        // if (isKingStatus) {
        //   goldReward = goldReward * 2;
        // }
        playerCharacter!.gold += goldReward;
        state.currentRoom!.rewards[rewardIndex].gold = null;
        break;
      case 'item':
        if (state.currentRoom!.rewards[rewardIndex].item != null) {
          playerCharacter!.items
              .add(state.currentRoom!.rewards[rewardIndex].item!);
        }
        state.currentRoom!.rewards[rewardIndex].item = null;
        break;
      case 'relic':
        if (state.currentRoom!.rewards[rewardIndex].relic != null) {
          playerCharacter!.relics
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
    updateState();
  }

  void _generateMap() {
    state.gameMap = generateMap();
    updateState();
  }

  void enterPause() {
    state.inPause = true;
    updateState();
  }

  void exitPause() {
    state.inPause = false;
    updateState();
  }

  void enterMap() {
    state.inMap = true;
    updateState();
  }

  void exitMap() {
    state.inMap = false;
    updateState();
  }

  void enterDeck({List<PlayableCard> cards = const []}) {
    if (cards.isEmpty) {
      return;
    }
    state.inDeck = cards;
    updateState();
  }

  void exitDeck() {
    state.inDeck = [];
    updateState();
  }

  void openLoreCard(PlayableCard card) {
    state.loreCard = card;
    updateState();
  }

  void closeLoreCard() {
    state.loreCard = null;
    updateState();
  }

  void visitTrader() {
    if (state.currentRoom == null) return;
    (state.currentRoom! as TradeRoom).visitedTrader = true;
    updateState();
  }

  List<Room> getNextAvailableRooms() {
    if (state.gameMap.isEmpty) return [];
    if (state.currentRoom == null) return state.gameMap[0];
    return state.currentRoom!.nextRooms;
  }

  void enterRoom(Room room) {
    if (playerCharacter == null) {
      return;
    }
    playerCharacter!.resetRoundStatuses();
    playerCharacter!.enterRoom();
    if (state.currentRoom == null) {
      state.updateRoom(room);
    } else if ((state.currentRoom != null &&
        state.currentRoom!.getCanLeaveRoom() &&
        // state.currentRoom!.enemies.isEmpty &&
        getNextAvailableRooms().contains(room))) {
      state.updateRoom(room);
    }

    state.isOpenedChest = null;
    if (state.currentRoom.runtimeType == EnemyRoom) {
      enemyRoomEnter(
          currentRoom: state.currentRoom!, playerCharacter: playerCharacter!);
    }
    updateState();
  }

  void nextTurn() {
    if (playerCharacter == null) {
      return;
    }
    if (state.currentRoom == null) {
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
    for (var enemy in state.currentRoom!.getEnemies()) {
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
    updateState();
  }

  getCurrentRoom() => state.currentRoom;

  PlayerCharacterNotifier _getPlayerCharacterNotifier() {
    return ref.read(playerCharacterProvider.notifier);
  }

  void fromJson(GameStateInterface savedInfo) {
    state.gameMode = savedInfo.gameMode;
    state.inMap = savedInfo.inMap;
    state.inPause = savedInfo.inPause;
    playerCharacter = savedInfo.playerCharacter;
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
            playerCharacter: playerCharacter,
            gameMap: state.gameMap,
            currentRoom: state.currentRoom,
            playerName: state.playerName ?? 'autosave')
        .toJson();
  }
}
