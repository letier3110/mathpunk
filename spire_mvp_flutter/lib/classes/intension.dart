import '../enums/intension_type.dart';

class Intension {
  late IntensionType type;
  late int baseDamage;
  late int count;

  Intension(
      {intensionType = IntensionType.offense,
      intensionDamage = 0,
      intensionCount = 1}) {
    type = intensionType;
    baseDamage = intensionDamage;
    count = intensionCount;
    // targets
    // effect (+hp, +maxhp, -hp, -maxhp, +armor, +status (strength))
  }
}
