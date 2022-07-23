enum CardType {
  attack,
  skill,
  power,
  status,
}

CardType decodeCardTypeFromJson(dynamic json) {
  switch (json) {
    case 'CardType.attack':
      return CardType.attack;

    case 'CardType.power':
      return CardType.power;

    case 'CardType.status':
      return CardType.status;

    case 'CardType.skill':
    default:
      return CardType.skill;
  }
}
