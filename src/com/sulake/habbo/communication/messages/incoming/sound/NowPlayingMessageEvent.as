package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;

    public class NowPlayingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NowPlayingMessageEvent(param1:Function)
        {
            super(param1, NowPlayingMessageParser);
        }

        public function getParser():NowPlayingMessageParser
        {
            return (this.var_334 as NowPlayingMessageParser);
        }


    }
}