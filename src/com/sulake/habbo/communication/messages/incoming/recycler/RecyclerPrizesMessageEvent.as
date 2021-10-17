package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerPrizesMessageParser;

    public class RecyclerPrizesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RecyclerPrizesMessageEvent(param1:Function)
        {
            super(param1, RecyclerPrizesMessageParser);
        }

        public function getParser():RecyclerPrizesMessageParser
        {
            return (var_334 as RecyclerPrizesMessageParser);
        }


    }
}