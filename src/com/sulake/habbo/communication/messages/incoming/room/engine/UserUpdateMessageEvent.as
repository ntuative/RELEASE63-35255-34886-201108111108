package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;

    public class UserUpdateMessageEvent extends MessageEvent 
    {

        public function UserUpdateMessageEvent(param1:Function)
        {
            super(param1, UserUpdateMessageParser);
        }

        public function getParser():UserUpdateMessageParser
        {
            return (var_334 as UserUpdateMessageParser);
        }


    }
}