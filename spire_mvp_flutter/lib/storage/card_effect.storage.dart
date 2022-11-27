import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/deal_damage.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/select_card.card_effect.dart';
import 'package:mathpunk_cardgame/classes/card_effects/select_target.card_effect.dart';

CardEffect cardEffectFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;

  CardEffect effect;

  switch (jsonRuntime) {
    case 'DealDamageCardEffect':
      effect = DealDamageCardEffect();
      break;
    case 'SelectCardCardEffect':
      effect = SelectCardCardEffect();
      break;
    case 'SelectTargetCardEffect':
      effect = SelectTargetCardEffect();
      break;
    default:
      effect = DealDamageCardEffect();
      break;
  }

  return effect;
}

Map cardEffectToJson(CardEffect effect) =>
    {...effect.toJson(), '_runtime': effect.runtimeType.toString()};
