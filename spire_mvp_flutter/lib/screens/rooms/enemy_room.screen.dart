import 'package:flutter/material.dart';
import 'package:mathpunk_cardgame/components/room/chest.view.dart';
import 'package:provider/provider.dart';
import 'package:mathpunk_cardgame/classes/room/enemy_room.dart';
import 'package:mathpunk_cardgame/components/room/card_reward.view.dart';
import 'package:mathpunk_cardgame/components/room/card_to_draw.view.dart';
import 'package:mathpunk_cardgame/components/room/rewards.screen.dart';
import 'package:mathpunk_cardgame/components/room/current_mana.view.dart';
import 'package:mathpunk_cardgame/components/room/discardpile.view.dart';
import 'package:mathpunk_cardgame/components/room/drawpile.view.dart';
import 'package:mathpunk_cardgame/components/room/endturn.view.dart';
import 'package:mathpunk_cardgame/components/pawn/enemy_pawn.view.dart';
import 'package:mathpunk_cardgame/components/room/game_over.view.dart';
import 'package:mathpunk_cardgame/components/room/hand.view.dart';
import 'package:mathpunk_cardgame/components/pawn/player_pawn.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

class EnemyRoomScreen extends StatefulWidget {
  final EnemyRoom room;

  const EnemyRoomScreen({required this.room, Key? key}) : super(key: key);

  @override
  State<EnemyRoomScreen> createState() => _EnemyRoomScreenState();
}

class _EnemyRoomScreenState extends State<EnemyRoomScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    bool isPlayerAlive = gameState.playerCharacter!.health > 0;
    bool isNoEnemies = gameState.currentRoom!.enemies.isEmpty;
    bool isSelectingCard = gameState.selectingTarget != null &&
        gameState.selectingTarget!.targetType == TargetEnum.cardTarget;
    bool isSelectingCardReward = gameState.selectingCardReward.isNotEmpty;
    bool isOpenedChest = gameState.isOpenedChest != null;

    return Container(
        // color: const Color(0xFF222222),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg5.png'), fit: BoxFit.fill),
        ),
        child: Stack(children: [
          ...widget.room.enemies.map((enemy) {
            return EnemyPawnView(
              enemy: enemy,
            );
          }),
          if (!isOpenedChest && isNoEnemies)
            Stack(
                children: widget.room.rewards
                    .map((entry) => ChestView(reward: entry))
                    .toList()),
          if (isOpenedChest && !isSelectingCardReward && isNoEnemies)
            Stack(
                children: widget.room.rewards
                    .asMap()
                    .entries
                    .map((entry) => RewardsScreen(
                        rewardIndex: entry.key, reward: entry.value))
                    .toList()),
          if (isSelectingCardReward)
            CardReward(cards: gameState.selectingCardReward),
          if (isPlayerAlive && !isNoEnemies) const PlayerPawnView(),
          if (!isPlayerAlive) const GameOver(),
          if (isPlayerAlive && !isNoEnemies) const EndturnView(),
          if (isPlayerAlive && !isNoEnemies) const CurrentManaView(),
          if (isPlayerAlive && !isNoEnemies) const DrawPileView(),
          if (isPlayerAlive && !isNoEnemies) const HandView(),
          if (isPlayerAlive && !isNoEnemies) const DiscardPileView(),
          if (isSelectingCard)
            CardToDraw(
                cards: gameState.selectingTarget!.getSelectableCards(),
                currentCard: gameState.selectingTarget!)
        ]));
  }
}
