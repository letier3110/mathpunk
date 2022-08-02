import 'package:spire_mvp_flutter/classes/base_character.dart';
import 'package:spire_mvp_flutter/classes/card/shiv.card.dart';
import 'package:spire_mvp_flutter/classes/items/consumable_item.dart';
import 'package:spire_mvp_flutter/classes/player/player.dart';
import 'package:spire_mvp_flutter/classes/player/player_character/player_character.dart';
import 'package:spire_mvp_flutter/enums/target.enum.dart';

int count = 3;

class CunningPotion extends ConsumableItem {
  CunningPotion()
      : super(
            itemName: 'Cunning Potion',
            itemDescription: 'Add 3 Shiv to your hand.',
            itemTargetType: TargetEnum.allTargets);

  @override
  String getItemDescription() {
    int localCount = count;

    return 'Add $localCount Shiv to your hand.';
  }

  @override
  play(List<BaseCharacter> target) {
    PlayerCharacter character = Player.getPlayerInstance().getCharacter();
    int localCount = count;
    for (var i = 0; i < localCount; i++) {
      character.getDeck().getHand().add(ShivCard());
    }
  }
}
