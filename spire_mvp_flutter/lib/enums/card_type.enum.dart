enum CardType {
  attack,
  skill,
  power,
}

CardType decodeCardTypeFromJson(dynamic json) {
  switch (json) {
    case CardType.attack:
      return CardType.attack;

    case CardType.power:
      return CardType.power;

    case CardType.skill:
    default:
      return CardType.skill;
  }
}
