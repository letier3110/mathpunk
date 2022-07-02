import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/room/discardpile.view.dart';
import 'package:spire_mvp_flutter/components/room/drawpile.view.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class EnemyRoomScreen extends StatefulWidget {
  const EnemyRoomScreen({Key? key}) : super(key: key);

  @override
  State<EnemyRoomScreen> createState() => _EnemyRoomScreenState();
}

class _EnemyRoomScreenState extends State<EnemyRoomScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    return Container(
        color: Colors.grey,
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Container(
              color: Colors.red,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Container(
                color: Colors.white,
                child: const Text('Enemy room'),
              )),
          const DrawPileView(),
          const DiscardPileView(),
        ]));
  }
}
