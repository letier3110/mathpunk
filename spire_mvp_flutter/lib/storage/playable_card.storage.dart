import 'package:spire_mvp_flutter/classes/card/anger.card.dart';
import 'package:spire_mvp_flutter/classes/card/blood_for_blood.card.dart';
import 'package:spire_mvp_flutter/classes/card/normality.card.dart';
import 'package:spire_mvp_flutter/classes/card/playable_card.dart';
import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';

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
    case 'BodySlamCard':
      card = BodySlamCard();
      break;
    case 'ClashCard':
      card = ClashCard();
      break;
    case 'CleaveCard':
      card = CleaveCard();
      break;
    case 'ClothesLineCard':
      card = ClothesLineCard();
      break;
    case 'FlexCard':
      card = FlexCard();
      break;
    case 'HeadbuttCard':
      card = HeadbuttCard();
      break;
    case 'HeavyBladeCard':
      card = HeavyBladeCard();
      break;
    case 'IronWaveCard':
      card = IronWaveCard();
      break;
    case 'PerfectStrikeCard':
      card = PerfectStrikeCard();
      break;
    case 'PommelStrikeCard':
      card = PommelStrikeCard();
      break;
    case 'ThunderclapCard':
      card = ThunderclapCard();
      break;
    case 'TrueGiftCard':
      card = TrueGiftCard();
      break;
    case 'TwinStrikeCard':
      card = TwinStrikeCard();
      break;
    case 'WarCryCard':
      card = WarCryCard();
      break;
    case 'ShivCard':
      card = ShivCard();
      break;
    case 'BloodForBloodCard':
      card = BloodForBloodCard();
      break;
    case 'NormalityCard':
      card = NormalityCard();
      break;
    default:
      card = StrikeCard();
      break;
  }

  return card;
}

Map playableCardToJson(PlayableCard playableCard) =>
    {...playableCard.toJson(), '_runtime': playableCard.runtimeType.toString()};
