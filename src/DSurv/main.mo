import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token {
  // Run dfx identity get-principal to get your principal id
  //Then replace it in the following line
  let owner : Principal = Principal.fromText("zqavz-jtvpj-uyoba-psgzb-eclsv-hmozc-qmkww-g5sv7-o76sn-77jfx-jae");
  let totalSupply : Nat = 1000000000;
  let symbol : Text = "DANG";
  //This is the Token canister address
  let tokenCanister : Principal = Principal.fromText("rrkah-fqaaa-aaaaa-aaaaq-cai");

  stable var balanceEntries : [(Principal, Nat)] = [];

  private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  if (balances.size() < 1) {
    balances.put(owner, totalSupply / 2);
    balances.put(tokenCanister, totalSupply / 2);
  };
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

  public shared (msg) func payOut() : async Text {
    // Debug.print(debug_show (msg.caller));
    if (balances.get(msg.caller) == null) {
      let amount = 10000;
      let result = await transfer(msg.caller, amount);
      return result;
    };
    return "Already Claimed";
  };

  public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
    let fromBalance = await balanceOf(msg.caller);
    //To Improve readability, I decided to use Guard Clauses instead of If-Else
    if (fromBalance < amount) {
      return "Insufficient Balance";
    };
    let newFromBalance : Nat = fromBalance - amount;
    balances.put(msg.caller, newFromBalance);
    let toBalance = await balanceOf(to);
    let newToBalance : Nat = toBalance + amount;
    balances.put(to, newToBalance);
    return "Success";
  };

  system func preupgrade() {
    balanceEntries := Iter.toArray(balances.entries());
  };

  system func postupgrade() {
    //As I am using a more newer version of DFX SDK
    // I had to change balanceEntries.val() to balanceEntries.vals()
    balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
    if (balances.size() < 1) {
      balances.put(owner, totalSupply / 2);
      balances.put(tokenCanister, totalSupply / 2);
    };
  };
};
