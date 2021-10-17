package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.OpenMessageParser;

    public class OpenEvent extends MessageEvent implements IMessageEvent 
    {

        public function OpenEvent(param1:Function)
        {
            super(param1, OpenMessageParser);
        }

        public function getParser():OpenMessageParser
        {
            return (this.var_334 as OpenMessageParser);
        }


    }
}