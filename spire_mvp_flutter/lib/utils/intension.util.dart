import 'package:mathpunk_cardgame/classes/intension.dart';
import 'package:mathpunk_cardgame/enums/intension_type.enum.dart';

String getIntensionType(Intension intension) {
  switch (intension.type) {
    case IntensionType.offense:
      return 'Attack';
    case IntensionType.defense:
      return 'Defend';
    // TODO: implement other intension types
    default:
      return 'Other';
  }
}
