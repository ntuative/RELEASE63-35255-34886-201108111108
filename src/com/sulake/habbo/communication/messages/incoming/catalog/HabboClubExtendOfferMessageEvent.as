package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;

    public class HabboClubExtendOfferMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboClubExtendOfferMessageEvent(param1:Function)
        {
            super(param1, HabboClubExtendOfferMessageParser);
        }

        public function getParser():HabboClubExtendOfferMessageParser
        {
            return (this.var_334 as HabboClubExtendOfferMessageParser);
        }


    }
}