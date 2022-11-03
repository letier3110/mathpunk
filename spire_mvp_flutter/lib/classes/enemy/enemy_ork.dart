import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'enemy.dart';

class EnemyOrk extends Enemy {
  EnemyOrk({String enemyName = 'ork'}) : super(enemyName: enemyName);

  @override
  String getNameTranslationKey(BuildContext context) =>
      AppLocalizations.of(context)!.orkEnemy;
  @override
  String getDescriptionTranslationKey(BuildContext context) =>
      'realityEchanterDescription';
}
