package com.sulake.habbo.messenger.domain
{
    import com.sulake.habbo.messenger.HabboMessenger;

    public class ConversationsDeps implements IConversationsDeps 
    {

        private var _messenger:HabboMessenger;

        public function ConversationsDeps(param1:HabboMessenger)
        {
            this._messenger = param1;
        }

        public function getTabCount():int
        {
            return (this._messenger.messengerView.getTabCount());
        }

        public function getText(param1:String):String
        {
            return (this._messenger.getText(param1));
        }

        public function createConversation(param1:int):Conversation
        {
            return (this._messenger.createConversation(param1));
        }

        public function refresh(param1:Boolean):void
        {
            this._messenger.messengerView.refresh();
        }

        public function addMsgToView(param1:Conversation, param2:Message):void
        {
            this._messenger.messengerView.addMsgToView(param1, param2);
        }


    }
}