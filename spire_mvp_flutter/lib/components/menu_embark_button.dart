import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/gamestate.provider.dart';
import 'package:mathpunk_cardgame/controllers/navigation.provider.dart';

import '../enums/screens.enum.dart';

class MenuEmbarkButton extends ConsumerStatefulWidget {
  const MenuEmbarkButton({Key? key}) : super(key: key);

  @override
  ConsumerState<MenuEmbarkButton> createState() => _MenuEmbarkButtonState();
}

class _MenuEmbarkButtonState extends ConsumerState<MenuEmbarkButton> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gamestateProvider.notifier);
    final navigation = ref.watch(navigationProvider.notifier);

    return Positioned(
      bottom: 0,
      right: 20,
      child: Stack(
        children: [
          GestureDetector(
              onTap: () => {
                    gameState.startGame(),
                    navigation.changeScreen(ScreenEnum.game)
                  },
              child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  margin: const EdgeInsets.fromLTRB(0, 8, 0, 32),
                  width: 120,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/menu_bg_2.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.embark,
                      style: const TextStyle(fontSize: 22.0),
                    ),
                  ))),
        ],
      ),
    );
  }
}
