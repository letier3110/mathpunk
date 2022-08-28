import { IEnemy } from './enemy.interface';

export class Enemy implements IEnemy {
  constructor({ name, description, health, maxHealth }: IEnemy) {
    this.name = name;
    this.description = description;
    this.health = health;
    this.maxHealth = maxHealth;
  }

  name: string;
  description: string;
  health: number;
  maxHealth: number;
}
