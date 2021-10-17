package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserChatlogMessageParser;

    public class UserChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserChatlogEvent(param1:Function)
        {
            super(param1, UserChatlogMessageParser);
        }

        public function getParser():UserChatlogMessageParser
        {
            return (var_334 as UserChatlogMessageParser);
        }


    }
}