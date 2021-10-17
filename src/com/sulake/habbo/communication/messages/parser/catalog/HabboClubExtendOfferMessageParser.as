package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboClubExtendOfferMessageParser implements IMessageParser 
    {

        private var var_3078:ClubOfferExtendData;


        public function flush():Boolean
        {
            this.var_3078 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3078 = new ClubOfferExtendData(param1);
            return (true);
        }

        public function offer():ClubOfferExtendData
        {
            return (this.var_3078);
        }


    }
}