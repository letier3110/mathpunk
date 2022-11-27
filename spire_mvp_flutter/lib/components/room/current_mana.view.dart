import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/controllers/player_character.provider.dart';

class CurrentManaView extends ConsumerStatefulWidget {
  const CurrentManaView({Key? key}) : super(key: key);

  @override
  ConsumerState<CurrentManaView> createState() => CurrentManaViewView();
}

class CurrentManaViewView extends ConsumerState<CurrentManaView> {
  @override
  Widget build(BuildContext context) {
    final playerCharacter = ref.watch(playerCharacterProvider);

    final mana = playerCharacter?.mana ?? '0';

    void onTapHandler() {
      // TODO: implement drawpile tap handler
    }

    return Positioned(
      bottom: 120,
      left: 20,
      child: GestureDetector(
        onTap: onTapHandler,
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(color: Colors.white, width: 2)
            ),
            child: Center(
              child: Text(
                mana.toString(),
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
