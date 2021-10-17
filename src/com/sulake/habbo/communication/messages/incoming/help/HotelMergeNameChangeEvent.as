package com.sulake.habbo.communication.messages.incoming.help
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.help.HotelMergeNameChangeParser;

    public class HotelMergeNameChangeEvent extends MessageEvent implements IMessageEvent 
    {

        public function HotelMergeNameChangeEvent(param1:Function)
        {
            super(param1, HotelMergeNameChangeParser);
        }

        public function getParser():HotelMergeNameChangeParser
        {
            return (var_334 as HotelMergeNameChangeParser);
        }


    }
}