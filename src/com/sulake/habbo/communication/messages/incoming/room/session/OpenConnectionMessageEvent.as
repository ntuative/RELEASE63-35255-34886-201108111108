package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageParser;

    public class OpenConnectionMessageEvent extends MessageEvent 
    {

        public function OpenConnectionMessageEvent(param1:Function)
        {
            super(param1, OpenConnectionMessageParser);
        }

        public function getParser():OpenConnectionMessageParser
        {
            return (var_334 as OpenConnectionMessageParser);
        }


    }
}