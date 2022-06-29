import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/components/room_card.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: const Text('Map Screen'),
        ),
        Container(
          color: Colors.red,
          margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Row(
              children:
                  gameState.gameMap.map((e) => RoomCard(room: e)).toList()),
        ),
      ]),
    );
  }
}
