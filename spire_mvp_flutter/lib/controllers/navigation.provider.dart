import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/screens.enum.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, ScreenEnum>((ref) {
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<ScreenEnum> {
  NavigationNotifier() : super(ScreenEnum.mainLoading);

  void changeScreen(ScreenEnum newScreen) {
    state = newScreen;
  }
}
