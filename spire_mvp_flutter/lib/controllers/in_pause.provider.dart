import 'package:flutter_riverpod/flutter_riverpod.dart';

final inPauseProvider = StateNotifierProvider<InPauseNotifier, bool>((ref) {
  return InPauseNotifier();
});

class InPauseNotifier extends StateNotifier<bool> {
  InPauseNotifier({bool inPause = false}) : super(inPause);

  void enterPause() {
    state = true;
  }

  void exitPause() {
    state = false;
  }
}
