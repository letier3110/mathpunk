import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/controllers/navigation.controller.dart';

class HeaderPause extends StatefulWidget {
  const HeaderPause({Key? key}) : super(key: key);

  @override
  State<HeaderPause> createState() => HeaderPauseView();
}

class HeaderPauseView extends State<HeaderPause> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: () => {
          gameState.inPause ? gameState.exitPause() : gameState.enterPause(),
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 80,
          color: Colors.black,
          child: const Center(
            child: Text(
              'Pause',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
