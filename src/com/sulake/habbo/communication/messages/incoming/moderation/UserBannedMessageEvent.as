package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.UserBannedMessageParser;

    public class UserBannedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserBannedMessageEvent(param1:Function)
        {
            super(param1, UserBannedMessageParser);
        }

        public function getParser():UserBannedMessageParser
        {
            return (var_334 as UserBannedMessageParser);
        }


    }
}