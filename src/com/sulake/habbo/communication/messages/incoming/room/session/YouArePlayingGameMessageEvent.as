package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouArePlayingGameMessageParser;

    public class YouArePlayingGameMessageEvent extends MessageEvent 
    {

        public function YouArePlayingGameMessageEvent(param1:Function)
        {
            super(param1, YouArePlayingGameMessageParser);
        }

        public function getParser():YouArePlayingGameMessageParser
        {
            return (var_334 as YouArePlayingGameMessageParser);
        }


    }
}