enum TargetEnum { singleTarget, allTargets, cardTarget, unplayable }

TargetEnum decodeTargetEnumFromJson(dynamic json) {
  switch (json) {
    case 'TargetEnum.allTargets':
      return TargetEnum.allTargets;
    case 'TargetEnum.cardTarget':
      return TargetEnum.cardTarget;
    case 'TargetEnum.unplayable':
      return TargetEnum.unplayable;

    case 'TargetEnum.singleTarget':
    default:
      return TargetEnum.singleTarget;
  }
}
