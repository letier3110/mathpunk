enum CardState {
  empty,
  inDrawPile,
  inHand,
  inDiscardPile,
  inDeck,
  selectingTarget,
  dealingDamage,
  playingEffects
}

CardState decodeCardStateFromJson(dynamic json) {
  switch (json) {
    case 'CardState.inDrawPile':
      return CardState.inDrawPile;
    case 'CardState.inHand':
      return CardState.inHand;
    case 'CardState.inDiscardPile':
      return CardState.inDiscardPile;
    case 'CardState.inDeck':
      return CardState.inDeck;
    case 'CardState.selectingTarget':
      return CardState.selectingTarget;
    case 'CardState.playingEffects':
      return CardState.playingEffects;

    case 'CardState.dealingDamage':
    default:
      return CardState.dealingDamage;
  }
}
