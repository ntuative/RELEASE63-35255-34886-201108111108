package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;

    public class RoomRatingEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomRatingEvent(param1:Function)
        {
            super(param1, RoomRatingMessageParser);
        }

        public function getParser():RoomRatingMessageParser
        {
            return (this.var_334 as RoomRatingMessageParser);
        }


    }
}