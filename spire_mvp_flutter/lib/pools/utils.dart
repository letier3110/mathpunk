import 'dart:math';

import 'package:spire_mvp_flutter/classes/probability.dart';

Probability<T> weightedRandomPick<T>(List<Probability<T>> options) {
  var i = 0;

  var weights = [];

  var rng = Random();

  for (i = 0; i < options.length; i++) {
    try {
      weights.add(options[i].weight + (weights[i - 1] ?? 0));
    } catch (e) {
      weights.add(options[i].weight);
    }
  }

  var random = rng.nextInt(weights[weights.length - 1]);

  for (i = 0; i < weights.length; i++) {
    if (weights[i] > random) {
      return options[i];
    }
  }
  return options[0];
}
