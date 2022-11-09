import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';

final playerCharacterProvider =
    StateNotifierProvider<PlayerCharacterNotifier, PlayerCharacter?>((ref) {
  return PlayerCharacterNotifier();
});

class PlayerCharacterNotifier extends StateNotifier<PlayerCharacter?> {
  PlayerCharacterNotifier() : super(PlayerCharacter());
}
