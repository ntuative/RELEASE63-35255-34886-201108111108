package com.sulake.habbo.communication.messages.incoming.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdMessageParser;

    public class RoomAdMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomAdMessageEvent(param1:Function)
        {
            super(param1, RoomAdMessageParser);
        }

        public function getParser():RoomAdMessageParser
        {
            return (this.var_334 as RoomAdMessageParser);
        }


    }
}