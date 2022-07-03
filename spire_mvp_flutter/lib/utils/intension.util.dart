import 'package:spire_mvp_flutter/classes/intension.dart';
import 'package:spire_mvp_flutter/enums/intension_type.dart';

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
