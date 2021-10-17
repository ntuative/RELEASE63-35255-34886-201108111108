package com.sulake.habbo.communication.messages.incoming.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;

    public class ShoutMessageEvent extends MessageEvent 
    {

        public function ShoutMessageEvent(param1:Function)
        {
            super(param1, ChatMessageParser);
        }

        public function getParser():ChatMessageParser
        {
            return (var_334 as ChatMessageParser);
        }


    }
}