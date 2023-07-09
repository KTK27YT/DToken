import React, { useState } from "react";
import { DSurv } from "../../../declarations/DSurv";
import { Principal } from "@dfinity/principal";
function Transfer() {

  const [recepientId, setrecepientId] = useState("");
  const [amount, setamount] = useState(0);
  const [feedback, setfeedback] = useState("");
  const [isDisabled, setisDisabled] = useState(false);
  const [isHidden, setisHidden] = useState(true);

  async function handleClick() {
    setisDisabled(true);
    const recipient = Principal.fromText(recepientId);
    const amountToTransfer = Number(amount);
    let result = await DSurv.transfer(recipient, amountToTransfer);
    setfeedback(result);
    setisDisabled(false);
    setisHidden(false);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={recepientId}
                onChange={(e) => { setrecepientId(e.target.value) }}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => { setamount(e.target.value) }}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled}>
            Transfer
          </button>
        </p>
        <p hidden={isHidden}>{feedback}</p>
      </div>
    </div>
  );
}

export default Transfer;
