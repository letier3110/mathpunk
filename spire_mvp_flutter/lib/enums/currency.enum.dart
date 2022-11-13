enum CurrencyEnum { gold, obsidianDust }

CurrencyEnum decodeCurrencyFromJson(dynamic json) {
  switch (json) {
    case 'CurrencyEnum.gold':
      return CurrencyEnum.gold;

    case 'CurrencyEnum.obsidianDust':
    default:
      return CurrencyEnum.obsidianDust;
  }
}
