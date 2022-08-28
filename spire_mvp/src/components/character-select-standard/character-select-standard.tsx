import React, { useState } from 'react';
import { useDispatch } from 'react-redux';

import { CharacterType, SelectableCharacter } from '../../interfaces/character.interface';
import { selectCharacterAction, selectGamemodeAction } from '../../store/game-state/game-state.actions';
import { useCharacterList } from '../../store/game-state/game-state.selectors';
import ContinueButton from '../button/continue-button';
import ReturnButton from '../button/return-button';
import CharacterCardList from '../character-card/character-card-list';
import DeckCard from '../deck-card/deck-card';
import { DeckCardSize } from '../deck-card/deck-card.type';
import Mock from '../mock/mock';
import { NavigatorScreens } from '../navigator/navigator.enum';
import s from './character-select-standard.module.css';

const CharacterSelectStandard: React.FC = () => {
  const [character, setCharacter] = useState<SelectableCharacter>(null);
  const dispatch = useDispatch();
  const characterList = useCharacterList();

  const handleClickReturn = () => {
    dispatch(selectGamemodeAction(null));
  };

  const handleSubmit = (submitCharacter: SelectableCharacter) => {
    if (character === submitCharacter) {
      setCharacter(null);
    } else {
      setCharacter(submitCharacter);
    }
  };

  const handleClickContinue = () => {
    dispatch(selectCharacterAction(character));
  };

  return (
    <div>
      {character === CharacterType.Warrior && <Mock screen={NavigatorScreens.Run} />}
      {character && (
        <div className={s.preview}>
          <h1>{characterList[character].name}</h1>
          <div className={s.row}>
            <div className={s.item}>
              <div>HP: </div>
              <div>
                {characterList[character].hitpoints}/{characterList[character].maxHitpoints}
              </div>
            </div>
            <div className={s.item}>
              <div>Gold:</div>
              <div>{characterList[character].gold}</div>
            </div>
          </div>
          <h2>{characterList[character].description}</h2>
          <div>
            Relics:
            {characterList[character].relics.map(relic => {
              return (
                <div key={relic.name}>
                  <div>{relic.name}</div>
                  <div>{relic.description}</div>
                </div>
              );
            })}
          </div>
          <div>
            Deck:
            <div className={s.deckList}>
              {characterList[character].deck.map((card, index) => {
                return <DeckCard size={DeckCardSize.Small} card={card} key={card.name + index} />;
              })}
            </div>
          </div>
        </div>
      )}
      <CharacterCardList temporarySelected={character} submit={handleSubmit} />
      <ReturnButton onClick={handleClickReturn}>Return</ReturnButton>
      {character && <ContinueButton onClick={handleClickContinue}>Continue</ContinueButton>}
    </div>
  );
};

export default CharacterSelectStandard;
