package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomThumbnailUpdateResultMessageParser;

    public class RoomThumbnailUpdateResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomThumbnailUpdateResultEvent(param1:Function)
        {
            super(param1, RoomThumbnailUpdateResultMessageParser);
        }

        public function getParser():RoomThumbnailUpdateResultMessageParser
        {
            return (this.var_334 as RoomThumbnailUpdateResultMessageParser);
        }


    }
}