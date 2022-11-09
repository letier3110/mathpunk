import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class GameOver extends ConsumerStatefulWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  ConsumerState<GameOver> createState() => GameOverView();
}

class GameOverView extends ConsumerState<GameOver> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);
    final navigation = ref.watch(navigationProvider.notifier);

    void onTapHandler() {
      gameState.stopPlaying();
      navigation.changeScreen(ScreenEnum.mainMenu);
    }

    return Positioned(
      top: 0,
      left: 200,
      right: 200,
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          height: 100,
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 400),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.endGameText,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: GestureDetector(
                onTap: onTapHandler,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(48, 16, 48, 16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(color: Colors.white, width: 2)
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.newStartText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )))
      ]),
    );
  }
}
