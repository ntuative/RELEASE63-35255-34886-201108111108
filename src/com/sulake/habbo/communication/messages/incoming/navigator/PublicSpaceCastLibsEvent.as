package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;

    public class PublicSpaceCastLibsEvent extends MessageEvent implements IMessageEvent 
    {

        public function PublicSpaceCastLibsEvent(param1:Function)
        {
            super(param1, PublicSpaceCastLibsMessageParser);
        }

        public function getParser():PublicSpaceCastLibsMessageParser
        {
            return (this.var_334 as PublicSpaceCastLibsMessageParser);
        }


    }
}