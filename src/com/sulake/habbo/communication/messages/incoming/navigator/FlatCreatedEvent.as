package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;

    public class FlatCreatedEvent extends MessageEvent implements IMessageEvent 
    {

        public function FlatCreatedEvent(param1:Function)
        {
            super(param1, FlatCreatedMessageParser);
        }

        public function getParser():FlatCreatedMessageParser
        {
            return (this.var_334 as FlatCreatedMessageParser);
        }


    }
}