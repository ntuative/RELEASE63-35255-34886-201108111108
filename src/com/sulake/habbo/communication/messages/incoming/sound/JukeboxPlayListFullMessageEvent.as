package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxPlayListFullMessageParser;

    public class JukeboxPlayListFullMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxPlayListFullMessageEvent(param1:Function)
        {
            super(param1, JukeboxPlayListFullMessageParser);
        }

        public function getParser():JukeboxPlayListFullMessageParser
        {
            return (this.var_334 as JukeboxPlayListFullMessageParser);
        }


    }
}