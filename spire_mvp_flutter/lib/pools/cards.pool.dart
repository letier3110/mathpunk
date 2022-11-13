import 'package:mathpunk_cardgame/classes/card/anger_card/anger.card.dart';
import 'package:mathpunk_cardgame/classes/card/anger_upgrade_card/anger.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_card/armaments.card.dart';
import 'package:mathpunk_cardgame/classes/card/armaments_upgrade_card/armaments.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/bash.card.dart';
import 'package:mathpunk_cardgame/classes/card/bash.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.card.dart';
import 'package:mathpunk_cardgame/classes/card/blood_for_blood.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/body_slam.card.dart';
import 'package:mathpunk_cardgame/classes/card/body_slam.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/clash.card.dart';
import 'package:mathpunk_cardgame/classes/card/clash.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/cleave.card.dart';
import 'package:mathpunk_cardgame/classes/card/cleave.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/clothes_line.card.dart';
import 'package:mathpunk_cardgame/classes/card/clothes_line.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/defend.card.dart';
import 'package:mathpunk_cardgame/classes/card/defend.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/doubt.card.dart';
import 'package:mathpunk_cardgame/classes/card/flex.card.dart';
import 'package:mathpunk_cardgame/classes/card/headbutt.card.dart';
import 'package:mathpunk_cardgame/classes/card/headbutt.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/heavy_blade.card.dart';
import 'package:mathpunk_cardgame/classes/card/heavy_blade.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/iron_wave.card.dart';
import 'package:mathpunk_cardgame/classes/card/iron_wave.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/double.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/double.upgrade.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/plus.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/plus.upgrade.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/quintuple.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/quintuple.upgrade.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/triple.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/math_cards/triple.upgrade.math.card.dart';
import 'package:mathpunk_cardgame/classes/card/normality.card.dart';
import 'package:mathpunk_cardgame/classes/card/perfect_strike.card.dart';
import 'package:mathpunk_cardgame/classes/card/perfect_strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card/pommel_strike.card.dart';
import 'package:mathpunk_cardgame/classes/card/pommel_strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/searing_blow.card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/shrug_it_off.card.dart';
import 'package:mathpunk_cardgame/classes/card/shrug_it_off.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/strike.card.dart';
import 'package:mathpunk_cardgame/classes/card/strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/thunderclap.card.dart';
import 'package:mathpunk_cardgame/classes/card/thunderclap.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/true_gift.card.dart';
import 'package:mathpunk_cardgame/classes/card/true_gift.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/twin_strike.card.dart';
import 'package:mathpunk_cardgame/classes/card/twin_strike.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/card/warcry.card.dart';
import 'package:mathpunk_cardgame/classes/card/warcry.upgrade.card.dart';
import 'package:mathpunk_cardgame/classes/probability.dart';

List<Probability<PlayableCard>> poolAllCards = [
  Probability(obj: DoubleMathCard(), weight: 1),
  Probability(obj: DoubleMathUpgradeCard(), weight: 1),
  Probability(obj: TripleMathCard(), weight: 1),
  Probability(obj: TripleMathUpgradeCard(), weight: 1),
  Probability(obj: QuintupleMathCard(), weight: 1),
  Probability(obj: QuintupleMathUpgradeCard(), weight: 1),
  Probability(obj: PlusMathCard(), weight: 1),
  Probability(obj: PlusMathUpgradeCard(), weight: 1),
  Probability(obj: AngerCard(), weight: 1),
  Probability(obj: AngerUpgradeCard(), weight: 1),
  Probability(obj: ArmamentsCard(), weight: 1),
  Probability(obj: ArmamentsUpgradeCard(), weight: 1),
  Probability(obj: BashCard(), weight: 1),
  Probability(obj: BashUpgradeCard(), weight: 1),
  Probability(obj: BloodForBloodCard(), weight: 1),
  Probability(obj: BloodForBloodUpgradeCard(), weight: 1),
  Probability(obj: BodySlamCard(), weight: 1),
  Probability(obj: BodySlamUpgradeCard(), weight: 1),
  Probability(obj: ClashCard(), weight: 1),
  Probability(obj: ClashUpgradeCard(), weight: 1),
  Probability(obj: CleaveCard(), weight: 1),
  Probability(obj: CleaveUpgradeCard(), weight: 1),
  Probability(obj: ClothesLineCard(), weight: 1),
  Probability(obj: ClothesLineUpgradeCard(), weight: 1),
  Probability(obj: DefendCard(), weight: 1),
  Probability(obj: DefendUpgradeCard(), weight: 1),
  Probability(obj: DoubtCard(), weight: 1),
  Probability(obj: FlexCard(), weight: 1),
  Probability(obj: HeadbuttCard(), weight: 1),
  Probability(obj: HeadbuttUpgradeCard(), weight: 1),
  Probability(obj: HeavyBladeCard(), weight: 1),
  Probability(obj: HeavyBladeUpgradeCard(), weight: 1),
  Probability(obj: IronWaveCard(), weight: 1),
  Probability(obj: IronWaveUpgradeCard(), weight: 1),
  Probability(obj: NormalityCard(), weight: 1),
  Probability(obj: PerfectStrikeCard(), weight: 1),
  Probability(obj: PerfectStrikeUpgradeCard(), weight: 1),
  Probability(obj: PommelStrikeCard(), weight: 1),
  Probability(obj: PommelStrikeUpgradeCard(), weight: 1),
  Probability(obj: SearingBlow(), weight: 1),
  Probability(obj: ShivCard(), weight: 1),
  Probability(obj: ShivUpgradeCard(), weight: 1),
  Probability(obj: ShrugItOffCard(), weight: 1),
  Probability(obj: ShrugItOffUpgradeCard(), weight: 1),
  Probability(obj: StrikeCard(), weight: 1),
  Probability(obj: StrikeUpgradeCard(), weight: 1),
  Probability(obj: ThunderclapCard(), weight: 1),
  Probability(obj: ThunderclapUpgradeCard(), weight: 1),
  Probability(obj: TrueGiftCard(), weight: 1),
  Probability(obj: TrueGiftUpgradeCard(), weight: 1),
  Probability(obj: TwinStrikeCard(), weight: 1),
  Probability(obj: TwinStrikeUpgradeCard(), weight: 1),
  Probability(obj: WarCryCard(), weight: 1),
  Probability(obj: WarCryUpgradeCard(), weight: 1),
];
