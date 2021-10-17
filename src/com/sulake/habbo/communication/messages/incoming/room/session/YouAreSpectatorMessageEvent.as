package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageParser;

    public class YouAreSpectatorMessageEvent extends MessageEvent 
    {

        public function YouAreSpectatorMessageEvent(param1:Function)
        {
            super(param1, YouAreSpectatorMessageParser);
        }

        public function getParser():YouAreSpectatorMessageParser
        {
            return (var_334 as YouAreSpectatorMessageParser);
        }


    }
}