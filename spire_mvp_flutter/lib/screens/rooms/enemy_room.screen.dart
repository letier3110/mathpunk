import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/components/room/card_reward.view.dart';
import 'package:spire_mvp_flutter/components/room/card_to_draw.view.dart';
import 'package:spire_mvp_flutter/components/room/chest.view.dart';
import 'package:spire_mvp_flutter/components/room/current_mana.view.dart';
import 'package:spire_mvp_flutter/components/room/discardpile.view.dart';
import 'package:spire_mvp_flutter/components/room/drawpile.view.dart';
import 'package:spire_mvp_flutter/components/room/endturn.view.dart';
import 'package:spire_mvp_flutter/components/room/enemy_pawn.view.dart';
import 'package:spire_mvp_flutter/components/room/game_over.view.dart';
import 'package:spire_mvp_flutter/components/room/hand.view.dart';
import 'package:spire_mvp_flutter/components/room/player_pawn.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

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

    return Container(
        color: const Color(0xFF222222),
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          ...widget.room.enemies.map((enemy) {
            return EnemyPawnView(
              enemy: enemy,
            );
          }),
          if (!isSelectingCardReward && isNoEnemies)
            ChestView(rewards: widget.room.rewards),
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
