import Map "mo:map/Map";
import { phash ; n32hash} "mo:map/Map";
import Types "types";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Utils "utils";
import List "mo:base/List";

actor {

    type Chat = Types.Chat;
    type ChatId = Types.ChatId;
    type User = Types.User;
    type SendMsgResult = Types.SendMsgResult;

    stable let chats = Map.new<ChatId, Chat>();
    stable let users = Map.new<Principal, User>();

    public query ({ caller }) func getMyChats() : async [ChatId] {
        let user = Map.get<Principal, User>(users, phash, caller);
        return switch user {
            case null { [] };
            case (?user) {
                List.toArray<ChatId>(user.chats);
            };
        };
    };

    public shared ({ caller }) func sendMsgToPrincipal(content : Text, assets : [Blob], to : Principal) : async SendMsgResult {
        // TODO assert caller isUser and to isUser
        let chatId = Utils.generateChatId([caller, to]);
        let chat = Map.get<ChatId, Chat>(chats, n32hash, chatId);
        let msg : Types.Msg = {
            from = caller;
            date = Time.now();
            content;
            assets;
        };
        switch chat {
            case null {
                let newChat : Chat = {
                    users = [caller, to];
                    msgs = List.fromArray<Types.Msg>([msg]);
                };
                ignore Map.put<ChatId,Chat>(chats, n32hash, chatId, newChat);

                #Ok("Sended Msg");
            };
            case(?chat){
                let msgs = List.push<Types.Msg>(msg, chat.msgs);
                ignore Map.put<ChatId,Chat>(chats, n32hash, chatId, {chat with msgs});
                
                #Ok("Sended Msg");
            }

        };
    };
};


