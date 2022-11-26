import 'package:flutter_riverpod/flutter_riverpod.dart';

final inMapProvider = StateNotifierProvider<InMapNotifier, bool>((ref) {
  return InMapNotifier();
});

class InMapNotifier extends StateNotifier<bool> {
  InMapNotifier({bool inMap = false}) : super(inMap);

  void enterMap() {
    state = true;
  }

  void exitMap() {
    state = false;
  }
}
