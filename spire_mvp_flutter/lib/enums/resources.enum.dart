enum ResourcesEnum { mana, obsidianDust, energy }

ResourcesEnum decodeResourcesFromJson(dynamic json) {
  switch (json) {
    case 'ResourcesEnum.mana':
      return ResourcesEnum.mana;

    case 'ResourcesEnum.obsidianDust':
      return ResourcesEnum.obsidianDust;

    case 'ResourcesEnum.energy':
    default:
      return ResourcesEnum.energy;
  }
}
