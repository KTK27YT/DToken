import React, { useState } from "react";
import { Principal } from "@dfinity/principal";
import { DSurv } from "../../../declarations/DSurv";

function Balance() {

  const [inputValue, setInputValue] = useState("");
  const [balanceresult, setBalanceResult] = useState("");
  const [Cryptosymbol, setCryptoSymbol] = useState("");
  const [isHidden, setHidden] = useState(true);
  async function handleClick() {
    // console.log("Balance Button Clicked");
    const principal = Principal.fromText(inputValue);
    const balance = await DSurv.balanceOf(principal);
    const symbol = await DSurv.getSymbol();
    setCryptoSymbol(symbol);
    setBalanceResult(balance.toLocaleString());
    setHidden(false);
  }


  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
        >
          Check Balance
        </button>
      </p>
      <p hidden={isHidden}>This account has a balance of {balanceresult} {Cryptosymbol}.</p>
    </div>
  );
}

export default Balance;
