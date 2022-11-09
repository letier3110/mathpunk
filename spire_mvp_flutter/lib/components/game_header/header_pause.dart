import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class HeaderPause extends ConsumerStatefulWidget {
  const HeaderPause({Key? key}) : super(key: key);

  @override
  ConsumerState<HeaderPause> createState() => HeaderPauseView();
}

class HeaderPauseView extends ConsumerState<HeaderPause> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);
    final gameStateNotifier = ref.watch(gamestateProvider.notifier);
    return Positioned(
      top: 0,
      bottom: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu_bg_2.png'), fit: BoxFit.fill),
        ),
        child: GestureDetector(
          onTap: () => {
            gameState.inPause
                ? gameStateNotifier.exitPause()
                : gameStateNotifier.enterPause(),
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            width: 90,
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.pauseText,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
