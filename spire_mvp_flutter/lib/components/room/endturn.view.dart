import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';

class EndturnView extends ConsumerStatefulWidget {
  const EndturnView({Key? key}) : super(key: key);

  @override
  ConsumerState<EndturnView> createState() => EndturnViewView();
}

class EndturnViewView extends ConsumerState<EndturnView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);

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
