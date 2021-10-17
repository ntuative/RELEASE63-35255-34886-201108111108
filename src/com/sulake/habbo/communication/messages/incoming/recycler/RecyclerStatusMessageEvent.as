package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageParser;

    public class RecyclerStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const var_665:int = 1;
        public static const var_666:int = 2;
        public static const var_667:int = 3;

        public function RecyclerStatusMessageEvent(param1:Function)
        {
            super(param1, RecyclerStatusMessageParser);
        }

        public function getParser():RecyclerStatusMessageParser
        {
            return (var_334 as RecyclerStatusMessageParser);
        }


    }
}