package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;

    public class PlayListMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListMessageEvent(param1:Function)
        {
            super(param1, PlayListMessageParser);
        }

        public function getParser():PlayListMessageParser
        {
            return (this.var_334 as PlayListMessageParser);
        }


    }
}