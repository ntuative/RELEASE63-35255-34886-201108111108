package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.ClubGiftSelectedParser;

    public class ClubGiftSelectedEvent extends MessageEvent implements IMessageEvent 
    {

        public function ClubGiftSelectedEvent(param1:Function)
        {
            super(param1, ClubGiftSelectedParser);
        }

        public function getParser():ClubGiftSelectedParser
        {
            return (this.var_334 as ClubGiftSelectedParser);
        }


    }
}