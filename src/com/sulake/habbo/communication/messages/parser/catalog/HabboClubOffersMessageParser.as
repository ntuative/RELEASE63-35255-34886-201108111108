package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboClubOffersMessageParser implements IMessageParser 
    {

        private var _offers:Array;


        public function flush():Boolean
        {
            this._offers = [];
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._offers = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this._offers.push(new ClubOfferData(param1));
                _loc3_++;
            };
            return (true);
        }

        public function get offers():Array
        {
            return (this._offers);
        }


    }
}