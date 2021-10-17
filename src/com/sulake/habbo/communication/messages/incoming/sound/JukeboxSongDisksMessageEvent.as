package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;

    public class JukeboxSongDisksMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxSongDisksMessageEvent(param1:Function)
        {
            super(param1, JukeboxSongDisksMessageParser);
        }

        public function getParser():JukeboxSongDisksMessageParser
        {
            return (this.var_334 as JukeboxSongDisksMessageParser);
        }


    }
}