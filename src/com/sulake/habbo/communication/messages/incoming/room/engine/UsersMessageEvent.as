package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;

    public class UsersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UsersMessageEvent(param1:Function)
        {
            super(param1, UsersMessageParser);
        }

        public function getParser():UsersMessageParser
        {
            return (var_334 as UsersMessageParser);
        }


    }
}