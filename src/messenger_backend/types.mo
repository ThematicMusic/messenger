import List "mo:base/List";

module {
    public type ChatId = Nat32;

    public type Msg = {
        from: Principal;
        //to is all others particiantes in the chat
        date: Int;
        content: Text;
        assets: [Blob]; //Images
    };

    public type Chat = {
        users : [Principal];
        msgs: List.List<Msg>;
    };

    public type User = {
        name: Text;
        chats: List.List<ChatId>;
    };

    public type SendMsgResult = {#Ok: Text; #Err: Text};
}