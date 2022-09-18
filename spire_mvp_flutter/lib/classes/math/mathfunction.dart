import 'package:mathpunk_cardgame/classes/card/playable_card.dart';

class Mathfunction {
  List<Mathslot?> slots = [];
  int slotsNumber = 1;
  Mathfunction({this.slotsNumber = 1}) {
    slots.add(null);
  }

  void setSlot(int slotNumber, Mathslot slot) {
    if (slotNumber >= slotsNumber || slotNumber < 0) {
      return;
    }
    slots[slotNumber] = slot;
  }

  Mathslot? getFirstUndefinedSlot() {
    for (int i = 0; i < slots.length; i++) {
      if (slots[i] == null) return slots[i];
      if (slots[i]!.isMathfunction()) {
        Mathslot? innerSlot = slots[i]!.mathfunction!.getFirstUndefinedSlot();
        if (innerSlot != null &&
            innerSlot.isMathfunction() == false &&
            innerSlot.isPlayableCard() == false) {
          return innerSlot;
        }
      }
    }
    return null;
  }

  void setFirstAvailableSlotMathfunction(Mathfunction mathfunction) {
    Mathslot? slot = getFirstUndefinedSlot();
    if (slot != null) {
      slot.assingMathfunction(mathfunction);
    }
  }

  void setFirstAvailableSlotPlayableCard(PlayableCard card) {
    Mathslot? slot = getFirstUndefinedSlot();
    if (slot != null) {
      slot.assignCard(card);
    }
  }

  bool isSlotDefined(int slotNumber) {
    if (slotNumber >= slotsNumber || slotNumber < 0) {
      return false;
    }
    return slots[slotNumber] != null;
  }
}

class Mathslot {
  late PlayableCard? card;
  late Mathfunction? mathfunction;

  // Moveset(Enemy enemyParent) {
  Mathslot();

  bool isMathfunction() {
    return mathfunction != null;
  }

  bool isPlayableCard() {
    return card != null;
  }

  void assignCard(PlayableCard card) {
    this.card = card;
  }

  void assingMathfunction(Mathfunction mathfunction) {
    this.mathfunction = mathfunction;
  }
}
