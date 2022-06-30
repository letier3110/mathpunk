import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/screens/enemy_room.screen.dart';
// import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';
import 'package:spire_mvp_flutter/screens/map.screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);
    // NavigationController navigation = Provider.of<NavigationController>(context, listen: false);

    if (gameState.inMap == true || gameState.currentRoom == null) {
      return const MapScreen();
    }
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: const Text('Enemy room'),
        ),
        if (gameState.inMap == true || gameState.currentRoom == null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: const MapScreen(),
          ),
        if (gameState.inMap == false && gameState.currentRoom != null)
          Container(
            margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: const EnemyRoomScreen(),
          ),
      ]),
    );
  }
}
