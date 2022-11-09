import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/components/create_profile.component.dart';
// import 'package:mathpunk_cardgame/classes/card/cards_implementation.dart';
// import 'package:mathpunk_cardgame/components/playable_card/playable_card.view.dart';
import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/saves.provider.dart';

import '../components/main_menu_item.dart';
import '../enums/screens.enum.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {
  final player = AudioPlayer();

  void playMenuTheme() async {
    await player.setSource(AssetSource('ambient/main_menu_2.mp3'));
    await player.setReleaseMode(ReleaseMode.loop);
    await player.resume();
  }

  void stopMenuTheme() async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.stop();
  }

  @override
  void initState() {
    super.initState();

    final currentSaveSlot =
        ref.read(savesProvider.select((value) => value.currentSaveSlot));
    final savesNotifier = ref.read(savesProvider.notifier);

    final gameMapIsEmpty =
        ref.read(gamestateProvider.select((value) => value.gameMap.isEmpty));
    final gamestateNotifier = ref.read(gamestateProvider.notifier);

    if (currentSaveSlot != null && gameMapIsEmpty) {
      savesNotifier.loadGame(gamestateNotifier);
    }
    playMenuTheme();
  }

  @override
  void dispose() {
    stopMenuTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saves = ref.watch(savesProvider);
    final gameMapIsEmpty =
        ref.watch(gamestateProvider.select((value) => value.gameMap.isEmpty));

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
          ),
          Center(
              child: Container(
            // padding: const EdgeInsets.fromLTRB(0, 0, 0, 160.0),
            // margin: const EdgeInsets.fromLTRB(400, 0, 400, 0),
            width: width / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo_empty_1.png'),
                  fit: BoxFit.contain),
            ),
          )),
          if (saves.currentSaveSlot == null) const CreateProfileComponent(),
          if (saves.currentSaveSlot != null)
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                saves.saveSlots[saves.currentSaveSlot!],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          if (saves.currentSaveSlot != null)
            Positioned(
              bottom: 0,
              child: Container(
                  margin: const EdgeInsets.all(8.0),
                  constraints:
                      const BoxConstraints(minWidth: 100, maxWidth: 300),
                  height: 500,
                  alignment: Alignment.bottomLeft,
                  width: width / 4,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [
                          if (gameMapIsEmpty == false)
                            MainMenuItem(
                              text: Text(
                                AppLocalizations.of(context)!.continueRun,
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              screen: ScreenEnum.game,
                            ),
                          if (gameMapIsEmpty)
                            MainMenuItem(
                              text: Text(
                                AppLocalizations.of(context)!.play,
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              screen: ScreenEnum.modeSelect,
                            ),
                          MainMenuItem(
                            text: Text(
                              AppLocalizations.of(context)!.compedium,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                            screen: ScreenEnum.compedium,
                          ),
                          MainMenuItem(
                            text: Text(
                              AppLocalizations.of(context)!.statistics,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                            screen: ScreenEnum.statistics,
                          ),
                          MainMenuItem(
                            text: Text(
                              AppLocalizations.of(context)!.settings,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                            screen: ScreenEnum.settings,
                          ),
                          MainMenuItem(
                            text: Text(
                              AppLocalizations.of(context)!.patchNotes,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                            screen: ScreenEnum.patchNotes,
                          ),
                          MainMenuItem(
                            text: Text(
                              AppLocalizations.of(context)!.quit,
                              style: const TextStyle(fontSize: 22.0),
                            ),
                            screen: ScreenEnum.quit,
                          ),
                        ]),
                      ),
                    ],
                  )),
            )
        ],
      ),
    );
  }
}
