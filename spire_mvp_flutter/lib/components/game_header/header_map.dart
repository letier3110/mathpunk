import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';
import 'package:spire_mvp_flutter/utils/font.util.dart';

class HeaderMap extends StatefulWidget {
  const HeaderMap({Key? key}) : super(key: key);

  @override
  State<HeaderMap> createState() => HeaderMapView();
}

class HeaderMapView extends State<HeaderMap> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);

    void onTapHandler() {
      gameState.exitPause();
      if (gameState.inMap == true) {
        gameState.exitMap();
      } else {
        gameState.enterMap();
      }
    }

    return Positioned(
      top: 0,
      bottom: 0,
      right: 200,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(8),
          color: Colors.black,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Map',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600),
                ),
              ]),
        ),
      ),
    );
  }
}
