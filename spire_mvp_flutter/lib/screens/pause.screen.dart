import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/in_pause.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.provider.dart';
import 'package:mathpunk_cardgame/enums/screens.enum.dart';

class PauseScreen extends ConsumerStatefulWidget {
  const PauseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PauseScreen> createState() => _PauseScreenState();
}

class _PauseScreenState extends ConsumerState<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);
    final navigation = ref.watch(navigationProvider.notifier);
    final saves = ref.watch(savesProvider.notifier);

    void onReturn() {
      ref.read(inPauseProvider.notifier).exitPause();
    }

    void onAbortRun() {
      gameState.stopPlaying();
      saves.saveGame(gameState);
      navigation.changeScreen(ScreenEnum.mainMenu);
    }

    void onSaveExit() {
      ref.read(inPauseProvider.notifier).exitPause();
      saves.saveGame(gameState);
      navigation.changeScreen(ScreenEnum.mainMenu);
      // TODO: persist state
      // exit(0)
    }

    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xEE000000),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Center(
            child: SizedBox(
              width: 500,
              height: 630,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size(500, 630),
                      child: const Image(
                          image: AssetImage('assets/pause_bg.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(100, 92, 100, 92),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: onReturn,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.returnText,
                                    style: const TextStyle(
                                        fontSize: 40, color: Colors.white)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onAbortRun,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .abandonRunText,
                                    style: const TextStyle(
                                        fontSize: 40, color: Colors.white)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onSaveExit,
                            child: Container(
                              width: 580,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/menu_bg_2.png'),
                                    fit: BoxFit.fill),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .saveAndExitText,
                                    style: const TextStyle(
                                        fontSize: 40, color: Colors.white)),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ))
    ]);
  }
}
