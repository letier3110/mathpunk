enum CardType { attack, skill, function, power, status, curse }

CardType decodeCardTypeFromJson(dynamic json) {
  switch (json) {
    case 'CardType.attack':
      return CardType.attack;
    case 'CardType.function':
      return CardType.function;
    case 'CardType.curse':
      return CardType.curse;

    case 'CardType.power':
      return CardType.power;

    case 'CardType.status':
      return CardType.status;

    case 'CardType.skill':
    default:
      return CardType.skill;
  }
}
