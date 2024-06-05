import Array "mo:base/Array";
import Principal "mo:base/Principal";
import Text "mo:base/Text";


module {
    public func generateChatId(users : [Principal]) : Nat32 {
        let arrayP = Array.sort<Principal>(users, Principal.compare);
        var concatP = "";
        for (p in arrayP.vals()) { concatP #= Principal.toText(p) };
        Text.hash(concatP);
    };

};
