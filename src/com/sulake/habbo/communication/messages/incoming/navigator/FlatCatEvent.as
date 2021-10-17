package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCatMessageParser;

    public class FlatCatEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatCatEvent(param1:Function)
        {
            super(param1, FlatCatMessageParser);
        }

        public function getParser():FlatCatMessageParser
        {
            return (this.var_334 as FlatCatMessageParser);
        }


    }
}