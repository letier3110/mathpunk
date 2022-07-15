import 'package:spire_mvp_flutter/classes/card/anger.card.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';

import '../classes/card/bash.card.dart';
import '../classes/card/defend.card.dart';
import '../classes/card/strike.card.dart';

PlayableCard playableCardFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;

  PlayableCard card;

  switch (jsonRuntime) {
    case 'StrikeCard':
      card = StrikeCard();
      break;
    case 'DefendCard':
      card = DefendCard();
      break;
    case 'BashCard':
      card = BashCard();
      break;
    case 'AngerCard':
      card = AngerCard();
      break;
    default:
      card = StrikeCard();
      break;
  }

  return card;
}

Map playableCardToJson(PlayableCard playableCard) =>
    {...playableCard.toJson(), '_runtime': playableCard.runtimeType.toString()};
