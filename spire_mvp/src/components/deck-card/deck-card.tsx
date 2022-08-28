import React, { useState } from 'react';

import { CardMetadata } from '../../interfaces/cards.interface';
import s from './deck-card.module.css';
import { DeckCardSize } from './deck-card.type';

interface DeckCardProps {
  card: CardMetadata;
  size?: DeckCardSize;
}

const DeckCard: React.FC<DeckCardProps> = ({ card, size = DeckCardSize.Medium }) => {
  const [preview, showPreview] = useState<boolean>(false);
  const { cardElement, name, description, manaCost } = card;

  const handleShowPreview = () => showPreview(true);
  const handleHidePreview = () => showPreview(false);

  return (
    <div className={s.container}>
      <div
        className={[s.item, s[cardElement], s[size]].join(' ')}
        onMouseEnter={handleShowPreview}
        onMouseLeave={handleHidePreview}
      >
        <div className={s.mana}>{manaCost}</div>
        <div className={s.name}>{name}</div>
        <div className={s.itemInner}>
          <div className={s.description}>{description}</div>
        </div>
      </div>
      {preview && (
        <div className={[s.item, s[cardElement], s.large, s.preview].join(' ')}>
          <div className={s.mana}>{manaCost}</div>
          <div className={s.name}>{name}</div>
          <div className={s.itemInner}>
            <div className={s.description}>{description}</div>
          </div>
        </div>
      )}
    </div>
  );
};

export default DeckCard;
