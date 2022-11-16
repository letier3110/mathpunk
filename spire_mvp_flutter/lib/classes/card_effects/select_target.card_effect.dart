import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/classes/card_effects/card_effect.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class SelectTargetCardEffect extends CardEffect {
  List<BaseCharacter> target = [];

  SelectTargetCardEffect({this.target = const []})
      : super(
            state: CardState.selectingTarget, isUserInteractionRequired: true);

  void selectTarget(List<BaseCharacter> target) {
    this.target = target;
  }

  @override
  void playEffect(PlayableCard card, Ref ref) {
    // TODO: implement playEffect
  }
}
