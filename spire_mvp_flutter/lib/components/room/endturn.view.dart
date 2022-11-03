import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.controller.dart';

class EndturnView extends StatefulWidget {
  const EndturnView({Key? key}) : super(key: key);

  @override
  State<EndturnView> createState() => EndturnViewView();
}

class EndturnViewView extends State<EndturnView> {
  @override
  Widget build(BuildContext context) {
    GamestateController gameState =
        Provider.of<GamestateController>(context, listen: false);

    void onTapHandler() {
      gameState.nextTurn();
    }

    return Positioned(
      bottom: 120,
      right: 20,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.white, width: 2)
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.endTurnText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
