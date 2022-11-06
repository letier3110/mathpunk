import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class HeaderMap extends StatefulWidget {
  const HeaderMap({Key? key}) : super(key: key);

  @override
  State<HeaderMap> createState() => HeaderMapView();
}

class HeaderMapView extends State<HeaderMap> {
  bool _hovered = false;

  void onEnterHandler(PointerEnterEvent p) {
    setState(() {
      _hovered = true;
    });
  }

  void onExitHandler(PointerExitEvent p) {
    setState(() {
      _hovered = false;
    });
  }

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
      child: MouseRegion(
        onEnter: onEnterHandler,
        onExit: onExitHandler,
        child: Container(
          decoration: _hovered
              ? const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 20.0,
                      spreadRadius: 0.0,
                    )
                  ],
                )
              : const BoxDecoration(),
          child: GestureDetector(
            onTap: onTapHandler,
            child: Container(
              width: 90,
              padding: const EdgeInsets.all(8),
              color: Colors.black,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.mapText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
