package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DoorOtherEndDeletedMessageParser;

    public class DoorOtherEndDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DoorOtherEndDeletedMessageEvent(param1:Function)
        {
            super(param1, DoorOtherEndDeletedMessageParser);
        }

        public function getParser():DoorOtherEndDeletedMessageParser
        {
            return (var_334 as DoorOtherEndDeletedMessageParser);
        }


    }
}