package com.sulake.habbo.communication.messages.incoming.room.chat
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.chat.UserTypingMessageParser;

    public class UserTypingMessageEvent extends MessageEvent 
    {

        public function UserTypingMessageEvent(param1:Function)
        {
            super(param1, UserTypingMessageParser);
        }

        public function getParser():UserTypingMessageParser
        {
            return (var_334 as UserTypingMessageParser);
        }


    }
}