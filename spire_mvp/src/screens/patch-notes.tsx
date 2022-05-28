import React from 'react';
import { useDispatch } from 'react-redux';

import ReturnButton from '../components/button/return-button';
// import Mock from '../components/mock/mock';
// import { NavigatorScreens } from '../components/navigator/navigator.enum';
import { restoreState } from '../store/game-state/game-state.actions';

function PatchNotes() {
  const dispatch = useDispatch();
  const handleClick = () => {
    dispatch(restoreState());
  };

  return (
    <div>
      {/* <Mock screen={NavigatorScreens.PatchNotes} /> */}
      <div>
        <div className="logo">Mathpunk spire</div>
        <button onClick={handleClick}>Restore initial state</button>
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default PatchNotes;
