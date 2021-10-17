package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.DoorbellMessageParser;

    public class DoorbellMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DoorbellMessageEvent(param1:Function)
        {
            super(param1, DoorbellMessageParser);
        }

        public function get userName():String
        {
            return ((this.var_334 as DoorbellMessageParser).userName);
        }


    }
}