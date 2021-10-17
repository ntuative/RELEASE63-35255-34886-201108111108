package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.NoSuchFlatMessageParser;

    public class NoSuchFlatEvent extends MessageEvent implements IMessageEvent 
    {

        public function NoSuchFlatEvent(param1:Function)
        {
            super(param1, NoSuchFlatMessageParser);
        }

        public function getParser():NoSuchFlatMessageParser
        {
            return (this.var_334 as NoSuchFlatMessageParser);
        }


    }
}