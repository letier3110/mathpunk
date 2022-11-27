import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerNameProvider =
    StateNotifierProvider<PlayerNameNotifier, String?>((ref) {
  return PlayerNameNotifier();
});

class PlayerNameNotifier extends StateNotifier<String?> {
  PlayerNameNotifier({String? name}) : super(name);

  void setPlayerName(String playerName) {
    state = playerName;
  }
}
