package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FavouriteMembershipUpdateMessageParser;

    public class FavoriteMembershipUpdateMessageEvent extends MessageEvent 
    {

        public function FavoriteMembershipUpdateMessageEvent(param1:Function)
        {
            super(param1, FavouriteMembershipUpdateMessageParser);
        }

        public function getParser():FavouriteMembershipUpdateMessageParser
        {
            return (var_334 as FavouriteMembershipUpdateMessageParser);
        }


    }
}