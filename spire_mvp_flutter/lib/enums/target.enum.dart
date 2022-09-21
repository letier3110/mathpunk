enum TargetEnum { singleTarget, allTargets, cardTarget }

TargetEnum decodeTargetEnumFromJson(dynamic json) {
  switch (json) {
    case 'TargetEnum.allTargets':
      return TargetEnum.allTargets;
    case 'TargetEnum.cardTarget':
      return TargetEnum.cardTarget;

    case 'TargetEnum.singleTarget':
    default:
      return TargetEnum.singleTarget;
  }
}
