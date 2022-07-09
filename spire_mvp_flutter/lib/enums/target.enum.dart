enum TargetEnum {
  playerTarget,
  singleTarget,
  allTargets,
  randomTarget,
}

TargetEnum decodeTargetEnumFromJson(dynamic json) {
  switch (json) {
    case TargetEnum.allTargets:
      return TargetEnum.allTargets;

    case TargetEnum.playerTarget:
      return TargetEnum.playerTarget;

    case TargetEnum.randomTarget:
      return TargetEnum.randomTarget;

    case TargetEnum.singleTarget:
    default:
      return TargetEnum.singleTarget;
  }
}
