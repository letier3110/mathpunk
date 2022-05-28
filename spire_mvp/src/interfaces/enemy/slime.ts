import { Enemy } from './enemy';

export class Slime extends Enemy {
  constructor() {
    const maxHp = Math.random() * 10 + 5;
    super({ name: 'Slime', description: 'A slimy creature', health: maxHp, maxHealth: maxHp });
  }
}
