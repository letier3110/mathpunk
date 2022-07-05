import 'package:flutter/material.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
// import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/classes/room/enemy_room.dart';
import 'package:spire_mvp_flutter/components/room/current_mana.view.dart';
import 'package:spire_mvp_flutter/components/room/discardpile.view.dart';
import 'package:spire_mvp_flutter/components/room/drawpile.view.dart';
import 'package:spire_mvp_flutter/components/room/endturn.view.dart';
import 'package:spire_mvp_flutter/components/room/enemy_pawn.view.dart';
import 'package:spire_mvp_flutter/components/room/hand.view.dart';
import 'package:spire_mvp_flutter/components/room/player_pawn.view.dart';
// import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class EnemyRoomScreen extends StatefulWidget {
  final EnemyRoom room;

  const EnemyRoomScreen({required this.room, Key? key}) : super(key: key);

  endTurn() {
    var character = Player.getPlayerInstance().getCharacter();
    var deck = character.deck;
    deck.draw(character.drawPower);
  }

  @override
  State<EnemyRoomScreen> createState() => _EnemyRoomScreenState();
}

class _EnemyRoomScreenState extends State<EnemyRoomScreen> {
  @override
  Widget build(BuildContext context) {
    // GamestateController gameState = Provider.of<GamestateController>(context);

    return Container(
        color: Colors.black87,
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          ...widget.room.enemies.map((enemy) {
            return EnemyPawnView(
              enemy: enemy,
            );
          }),
          const PlayerPawnView(),
          const EndturnView(),
          const CurrentManaView(),
          const DrawPileView(),
          const HandView(),
          const DiscardPileView(),
        ]));
  }
}
