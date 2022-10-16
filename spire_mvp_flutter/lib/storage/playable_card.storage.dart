import 'package:mathpunk_cardgame/classes/card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.card.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/normality.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';

import '../classes/card/bash.card.dart';
import '../classes/card/body_slam.card.dart';
import '../classes/card/clash.card.dart';
import '../classes/card/cleave.card.dart';
import '../classes/card/clothes_line.card.dart';
import '../classes/card/defend.card.dart';
import '../classes/card/flex.card.dart';
import '../classes/card/headbutt.card.dart';
import '../classes/card/heavy_blade.card.dart';
import '../classes/card/iron_wave.card.dart';
import '../classes/card/perfect_strike.card.dart';
import '../classes/card/pommel_strike.card.dart';
import '../classes/card/strike.card.dart';
import '../classes/card/thunderclap.card.dart';
import '../classes/card/true_gift.card.dart';
import '../classes/card/twin_strike.card.dart';
import '../classes/card/warcry.card.dart';

PlayableCard playableCardFromJson(dynamic json) {
  String jsonRuntime = json['_runtime'] as String;

  PlayableCard card;

  bool temporary = json['temporary'] as bool;

  switch (jsonRuntime) {
    case 'StrikeCard':
      card = StrikeCard(cardTemporary: temporary);
      break;
    case 'DefendCard':
      card = DefendCard(cardTemporary: temporary);
      break;
    case 'BashCard':
      card = BashCard(cardTemporary: temporary);
      break;
    case 'AngerCard':
      card = AngerCard(cardTemporary: temporary);
      break;
    case 'BodySlamCard':
      card = BodySlamCard(cardTemporary: temporary);
      break;
    case 'ClashCard':
      card = ClashCard(cardTemporary: temporary);
      break;
    case 'CleaveCard':
      card = CleaveCard(cardTemporary: temporary);
      break;
    case 'ClothesLineCard':
      card = ClothesLineCard(cardTemporary: temporary);
      break;
    case 'FlexCard':
      card = FlexCard(cardTemporary: temporary);
      break;
    case 'HeadbuttCard':
      card = HeadbuttCard(cardTemporary: temporary);
      break;
    case 'HeavyBladeCard':
      card = HeavyBladeCard(cardTemporary: temporary);
      break;
    case 'IronWaveCard':
      card = IronWaveCard(cardTemporary: temporary);
      break;
    case 'PerfectStrikeCard':
      card = PerfectStrikeCard(cardTemporary: temporary);
      break;
    case 'PommelStrikeCard':
      card = PommelStrikeCard(cardTemporary: temporary);
      break;
    case 'ThunderclapCard':
      card = ThunderclapCard(cardTemporary: temporary);
      break;
    case 'TrueGiftCard':
      card = TrueGiftCard(cardTemporary: temporary);
      break;
    case 'TwinStrikeCard':
      card = TwinStrikeCard(cardTemporary: temporary);
      break;
    case 'WarCryCard':
      card = WarCryCard(cardTemporary: temporary);
      break;
    case 'ShivCard':
      card = ShivCard(cardTemporary: temporary);
      break;
    case 'BloodForBloodCard':
      card = BloodForBloodCard(cardTemporary: temporary);
      break;
    case 'NormalityCard':
      card = NormalityCard(cardTemporary: temporary);
      break;
    case 'DoubtCard':
      card = DoubtCard(cardTemporary: temporary);
      break;
    default:
      card = StrikeCard(cardTemporary: temporary);
      break;
  }

  return card;
}

Map playableCardToJson(PlayableCard playableCard) =>
    {...playableCard.toJson(), '_runtime': playableCard.runtimeType.toString()};
