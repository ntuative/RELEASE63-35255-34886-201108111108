package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubOffersMessageParser;

    public class HabboClubOffersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboClubOffersMessageEvent(param1:Function)
        {
            super(param1, HabboClubOffersMessageParser);
        }

        public function getParser():HabboClubOffersMessageParser
        {
            return (this.var_334 as HabboClubOffersMessageParser);
        }


    }
}