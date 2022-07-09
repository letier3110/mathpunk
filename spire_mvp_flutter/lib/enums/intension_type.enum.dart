enum IntensionType {
  offense,
  defense,
  buff,
  debuff,
  offenseBuff,
  defenseBuff,
  offenseDebuff,
  defenseDebuff,
  defenseOffense,
  special,
}

IntensionType decodeIntensionTypeFromJson(dynamic json) {
  switch (json) {
    case IntensionType.offense:
      return IntensionType.offense;

    case IntensionType.defense:
      return IntensionType.defense;

    case IntensionType.buff:
      return IntensionType.buff;

    case IntensionType.debuff:
      return IntensionType.debuff;

    case IntensionType.offenseBuff:
      return IntensionType.offenseBuff;

    case IntensionType.defenseBuff:
      return IntensionType.defenseBuff;

    case IntensionType.offenseDebuff:
      return IntensionType.offenseDebuff;

    case IntensionType.defenseDebuff:
      return IntensionType.defenseDebuff;

    case IntensionType.defenseOffense:
      return IntensionType.defenseOffense;

    case IntensionType.special:
    default:
      return IntensionType.special;
  }
}
