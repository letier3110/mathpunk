import React from "react";
import { emptyFn } from "../../utils/empty-fn";
import { CharacterCardItemInterface } from "./character-card.types";

import s from "./character-card.module.css";

interface CharacterCardProps extends CharacterCardItemInterface {
  selected?: boolean;
}

const CharacterCard: React.FC<CharacterCardProps> = ({
  title,
  // description,
  callback = emptyFn,
  // imgSrc,
  disabled = false,
  selected = false,
}) => {
  const handleClick = () => {
    if (disabled) return void 0;
    callback();
  };
  return (
    <div
      className={[
        s.item,
        disabled && s.itemDisabled,
        selected && s.itemSelected,
      ].join(" ")}
      onClick={handleClick}
    >
      <div className={s.title}>{title.substring(0, 1)}</div>
    </div>
  );
};

export default CharacterCard;
