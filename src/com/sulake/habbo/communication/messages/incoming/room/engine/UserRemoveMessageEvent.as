package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;

    public class UserRemoveMessageEvent extends MessageEvent 
    {

        public function UserRemoveMessageEvent(param1:Function)
        {
            super(param1, UserRemoveMessageParser);
        }

        public function getParser():UserRemoveMessageParser
        {
            return (var_334 as UserRemoveMessageParser);
        }


    }
}