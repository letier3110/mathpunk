import 'attack_card.dart';
import 'attack_card_type.dart';

final strikeCard = AttackCard(
    cardName: 'Strike',
    cardDescription: 'Deal 10 damage to target enemy',
    cardMana: 1,
    cardSubType: AttackCardType.singleTarget,
    cardDamage: 10);
