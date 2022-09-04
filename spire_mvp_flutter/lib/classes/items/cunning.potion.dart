import 'package:mathpunk_cardgame/classes/base_character.dart';
import 'package:mathpunk_cardgame/classes/card/shiv.card.dart';
import 'package:mathpunk_cardgame/classes/items/consumable_item.dart';
import 'package:mathpunk_cardgame/classes/player/player.dart';
import 'package:mathpunk_cardgame/classes/player/player_character/player_character.dart';
import 'package:mathpunk_cardgame/enums/target.enum.dart';

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
  String getAssetImage() {
    return 'assets/orange_potion.png';
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
