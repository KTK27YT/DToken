import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor Token {
  // Run dfx identity get-principal to get your principal id
  //Then replace it in the following line
  var owner : Principal = Principal.fromText("zqavz-jtvpj-uyoba-psgzb-eclsv-hmozc-qmkww-g5sv7-o76sn-77jfx-jae");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "DANG";

  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

  balances.put(owner, totalSupply);

  public query func balanceOf(who : Principal) : async Nat {

    //Optional Statement
    let balance : Nat = switch (balances.get(who)) {
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  //Challenge: Return the Symbol of the currency
  public query func getSymbol() : async Text {
    return symbol;
  };
};
