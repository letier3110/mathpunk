import 'dart:async';

import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';

Stream<int> timedCounter(List<CardEffect> effects, [int? startingEffect]) {
  late StreamController<int> controller;
  Timer? timer;
  int currentEffect = startingEffect ?? 0;

  void tick(_) {
    controller.add(currentEffect);
    if (currentEffect == effects.length) {
      timer?.cancel();
      controller.close();
    }
    currentEffect++;
  }

  void startTimer() {
    timer = Timer.periodic(effects[currentEffect].duration, tick);
    // sleep(Duration(seconds: element));
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer);

  return controller.stream;
}

// void listenWithPause(List<CardEffect> effects) {
//   var counterStream = timedCounter(effects);
//   late StreamSubscription<int> subscription;

//   subscription = counterStream.listen((int counter) {
//     if (effects[counter].isUserInteractionRequired) {
//       subscription.pause();
//       return;
//     }
//     effects[counter].playEffect(card, ref);
//   });
// }
