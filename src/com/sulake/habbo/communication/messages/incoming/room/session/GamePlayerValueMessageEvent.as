package com.sulake.habbo.communication.messages.incoming.room.session
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageParser;

    public class GamePlayerValueMessageEvent extends MessageEvent 
    {

        public function GamePlayerValueMessageEvent(param1:Function)
        {
            super(param1, GamePlayerValueMessageParser);
        }

        public function getParser():GamePlayerValueMessageParser
        {
            return (var_334 as GamePlayerValueMessageParser);
        }


    }
}