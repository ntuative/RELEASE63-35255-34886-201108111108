package com.sulake.habbo.communication.messages.incoming.handshake
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;

    public class GenericErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function GenericErrorEvent(param1:Function)
        {
            super(param1, GenericErrorParser);
        }

        public function getParser():GenericErrorParser
        {
            return (this.var_334 as GenericErrorParser);
        }


    }
}