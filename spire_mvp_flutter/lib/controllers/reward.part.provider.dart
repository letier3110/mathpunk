import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/controllers/current_room.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_map.provider.dart';
import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';
import 'package:mathpunk_cardgame/controllers/selecting_card_reward.provider.dart';

final rewardPartProvider =
    StateNotifierProvider<RewarPartdNotifier, void>((ref) {
  return RewarPartdNotifier(ref: ref);
});

class RewarPartdNotifier extends StateNotifier<void> {
  final Ref ref;
  List<PlayableCard> selectingCardReward;

  RewarPartdNotifier({this.selectingCardReward = const [], required this.ref})
      : super([]);

  void selectCardReward(List<PlayableCard> cards) {
    ref.read(selectingCardRewardProvider.notifier).addRewards(cards);
  }

  void stopSelectingCardReward() {
    ref.read(selectingCardRewardProvider.notifier).removeRewards();
    checkIfEveryRewardGet();
  }

  void pickCardReward(List<PlayableCard> cards, PlayableCard pickedCard) {
    final playerCharacter = ref.read(playerCharacterProvider);
    final currentRoom = ref.read(currentRoomProvider);

    if (currentRoom == null) return;
    if (playerCharacter == null) return;

    try {
      playerCharacter.deck.addToDeck(pickedCard);
      int i = currentRoom.rewards.indexWhere((element) =>
          element.cards.every((element) => cards.contains(element)));
      currentRoom.rewards[i].cards = [];
    } catch (e) {
      //
    }

    stopSelectingCardReward();
  }

  void pickReward(int rewardIndex, String fieldType) {
    final playerCharacter = ref.read(playerCharacterProvider);
    final currentRoom = ref.read(currentRoomProvider);

    if (currentRoom == null) return;
    if (playerCharacter == null) return;
    // List<Status> statuses = playerCharacter!.getStatuses();
    switch (fieldType) {
      case 'gold':
        int goldReward = currentRoom.rewards[rewardIndex].gold ?? 0;
        // bool isKingStatus = castStatusToBool(statuses, KingStatus);
        // if (isKingStatus) {
        //   goldReward = goldReward * 2;
        // }
        playerCharacter.gold += goldReward;
        currentRoom.rewards[rewardIndex].gold = null;
        break;
      case 'item':
        if (currentRoom.rewards[rewardIndex].item != null) {
          playerCharacter.items.add(currentRoom.rewards[rewardIndex].item!);
        }
        currentRoom.rewards[rewardIndex].item = null;
        break;
      case 'relic':
        if (currentRoom.rewards[rewardIndex].relic != null) {
          playerCharacter.relics.add(currentRoom.rewards[rewardIndex].relic!);
        }
        currentRoom.rewards[rewardIndex].relic = null;
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
    final currentRoom = ref.read(currentRoomProvider);

    if (currentRoom != null) {
      if (currentRoom.rewards.every((element) =>
          element.cards.isEmpty &&
          element.gold == null &&
          element.item == null &&
          element.relic == null)) {
        ref.read(inMapProvider.notifier).enterMap();
      }
    }
  }
}
