package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageParser;

    public class PresentOpenedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PresentOpenedMessageEvent(param1:Function)
        {
            super(param1, PresentOpenedMessageParser);
        }

        public function getParser():PresentOpenedMessageParser
        {
            return (var_334 as PresentOpenedMessageParser);
        }


    }
}