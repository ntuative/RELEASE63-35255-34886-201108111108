package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;

    public class CantConnectMessageEvent extends MessageEvent 
    {

        public function CantConnectMessageEvent(param1:Function)
        {
            super(param1, CantConnectMessageParser);
        }

        public function getParser():CantConnectMessageParser
        {
            return (var_334 as CantConnectMessageParser);
        }


    }
}