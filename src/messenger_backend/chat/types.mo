module {
    public type Msg = {
        from: Principal;
        //to is all others particiantes in the chat
        date: Int;
        content: Text;
        assets: [Blob]; //Images
    };
    public type Chat = {
        participantes : [Principal];
        msgs: [Msg]
    };
}