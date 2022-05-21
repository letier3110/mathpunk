import React from "react";
import MainButton from "../components/button/main-button";
import ReturnButton from "../components/button/return-button";
import Mock from "../components/mock/mock";
import { NavigatorScreens } from "../components/navigator/navigator.enum";

function PatchNotes() {
  return (
    <div>
      <Mock screen={NavigatorScreens.PatchNotes} />
      <div>
        <div className="logo">Mathpunk spire</div>
        <ReturnButton>Return</ReturnButton>
      </div>
    </div>
  );
}

export default PatchNotes;
