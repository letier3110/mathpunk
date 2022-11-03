import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'enemy.dart';

class EnemySlime extends Enemy {
  EnemySlime({String enemyName = 'slime'}) : super(enemyName: enemyName);

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.slimeEnemy;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      'realityEchanterDescription';
}
