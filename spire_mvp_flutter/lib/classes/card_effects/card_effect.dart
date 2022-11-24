import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathpunk_cardgame/classes/card/playable_card.dart';
import 'package:mathpunk_cardgame/components/card_name.dart';
import 'package:mathpunk_cardgame/enums/card_state.enum.dart';

class CardEffect {
  CardEffect(
      {required this.state,
      this.isShown = false,
      this.isUserInteractionRequired = false,
      this.id = 0,
      this.duration = 0});
  CardState state;
  bool isShown = false;
  bool isUserInteractionRequired = false;
  int id = 0;
  int duration;

  void setId(int id) {
    this.id = id;
  }

  static isEqual(CardEffect a, CardEffect b) {
    return a.id == b.id;
  }

  StatefulWidget getCardEffectDescription() {
    // return const AngerCardDescription();

    return const CardName();
  }

  void playEffect(PlayableCard card, Ref ref) {}

  factory CardEffect.fromJson(dynamic json) {
    return CardEffect(
        state: decodeCardStateFromJson(json['state']),
        isShown: (json['state'] as bool),
        isUserInteractionRequired: (json['isUserInteractionRequired'] as bool));
  }

  Map toJson() => {
        'from': state.toString(),
        'isShown': isShown,
        'isUserInteractionRequired': isUserInteractionRequired,
      };
}
