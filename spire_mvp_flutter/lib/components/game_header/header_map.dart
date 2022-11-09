import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class HeaderMap extends ConsumerStatefulWidget {
  const HeaderMap({Key? key}) : super(key: key);

  @override
  ConsumerState<HeaderMap> createState() => HeaderMapView();
}

class HeaderMapView extends ConsumerState<HeaderMap> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider);
    final gameStateNotifier = ref.watch(gamestateProvider.notifier);

    void onTapHandler() {
      gameStateNotifier.exitPause();
      if (gameState.inMap == true) {
        gameStateNotifier.exitMap();
      } else {
        gameStateNotifier.enterMap();
      }
    }

    return Positioned(
      top: 0,
      bottom: 0,
      right: 200,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu_bg_2.png'), fit: BoxFit.fill),
        ),
        child: GestureDetector(
          onTap: onTapHandler,
          child: Container(
            width: 90,
            padding: const EdgeInsets.all(8),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    );
  }
}
