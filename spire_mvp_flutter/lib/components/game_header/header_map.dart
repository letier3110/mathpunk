import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spire_mvp_flutter/controllers/gamestate.controller.dart';

class HeaderMap extends StatefulWidget {
  const HeaderMap({Key? key}) : super(key: key);

  @override
  State<HeaderMap> createState() => HeaderMapView();
}

class HeaderMapView extends State<HeaderMap> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState = Provider.of<GamestateController>(context);
    return Positioned(
      top: 0,
      bottom: 0,
      right: 220,
      child: GestureDetector(
        onTap: () => {
          gameState.enterMap(),
        },
        child: Container(
          width: 100,
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
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ]),
        ),
      ),
    );
  }
}
