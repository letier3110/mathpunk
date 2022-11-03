import 'package:flutter/material.dart';

class Relic {
  late String name;
  late String description;

  Relic({relicName = 'DEFAULT_RELIC', relicDescription = 'DEFAULT_RELIC'}) {
    name = relicName;
    description = relicDescription;
  }

  String getNameTranslationKey(BuildContext context) => 'realityEchanterName';
  String getDescriptionTranslationKey(BuildContext context) =>
      'realityEchanterDescription';

  play() {
    // can be failed,
    // because of not correctly loaded from memory state or wrongly casted.
    // Relic class in not used directly, only as Generic Type
    throw UnimplementedError();
  }

  bool isVisible() => true;

  String getAssetImage() {
    return 'assets/gray_potion.png';
  }

  factory Relic.fromJson(dynamic json) {
    return Relic(
      relicName: json['name'] as String,
      relicDescription: json['description'] as String,
    );
  }

  Map toJson() => {
        'name': name,
        'description': description,
      };
}
