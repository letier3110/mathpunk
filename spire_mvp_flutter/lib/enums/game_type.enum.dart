enum GameTypeEnum { standard, daily, custom }

GameTypeEnum decodeGameTypeFromJson(dynamic json) {
  switch (json) {
    case GameTypeEnum.standard:
      return GameTypeEnum.standard;

    case GameTypeEnum.daily:
      return GameTypeEnum.daily;

    case GameTypeEnum.custom:
    default:
      return GameTypeEnum.custom;
  }
}
