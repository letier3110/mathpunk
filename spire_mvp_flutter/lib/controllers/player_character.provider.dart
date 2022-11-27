import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/notifiers/player_character.notifier.dart';

final playerCharacterProvider =
    StateNotifierProvider<PlayerCharacterNotifier, PlayerCharacter?>((ref) {
  return PlayerCharacterNotifier();
});
