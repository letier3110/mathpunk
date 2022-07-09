import '../enums/intension_type.enum.dart';

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

  void setType(IntensionType type) {
    this.type = type;
  }

  void setDamage(int baseDamage) {
    this.baseDamage = baseDamage;
  }

  void setCount(int count) {
    this.count = count;
  }

  factory Intension.fromJson(dynamic json) {
    int jsonDamage = json['baseDamage'] as int;
    int jsonCount = json['count'] as int;
    IntensionType jsonType = decodeIntensionTypeFromJson(json['type']);

    Intension jsonIntension = Intension(
        intensionType: jsonType,
        intensionDamage: jsonDamage,
        intensionCount: jsonCount);

    return jsonIntension;
  }

  Map toJson() =>
      {'type': type.toString(), 'baseDamage': baseDamage, 'count': count};
}
