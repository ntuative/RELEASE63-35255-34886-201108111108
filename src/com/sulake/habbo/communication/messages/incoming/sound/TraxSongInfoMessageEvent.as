package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;

    public class TraxSongInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TraxSongInfoMessageEvent(param1:Function)
        {
            super(param1, TraxSongInfoMessageParser);
        }

        public function getParser():TraxSongInfoMessageParser
        {
            return (this.var_334 as TraxSongInfoMessageParser);
        }


    }
}