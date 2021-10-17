package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;

    public class PlayListSongAddedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListSongAddedMessageEvent(param1:Function)
        {
            super(param1, PlayListSongAddedMessageParser);
        }

        public function getParser():PlayListSongAddedMessageParser
        {
            return (this.var_334 as PlayListSongAddedMessageParser);
        }


    }
}