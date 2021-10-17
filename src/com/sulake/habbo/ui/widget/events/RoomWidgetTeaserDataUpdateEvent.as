package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetTeaserDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1597:String = "RWTDUE_TEASER_DATA";
        public static const var_1598:String = "RWTDUE_GIFT_DATA";
        public static const var_1599:String = "RWTDUE_GIFT_RECEIVED";

        private var var_1678:int;
        private var _data:String;
        private var var_2549:int;
        private var var_3826:String;
        private var var_3824:String;
        private var var_3825:Boolean;
        private var var_3827:int = 0;
        private var var_5261:String;

        public function RoomWidgetTeaserDataUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(param1, param2, param3);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get data():String
        {
            return (this._data);
        }

        public function get status():int
        {
            return (this.var_2549);
        }

        public function get firstClickUserName():String
        {
            return (this.var_3824);
        }

        public function get giftWasReceived():Boolean
        {
            return (this.var_3825);
        }

        public function get ownRealName():String
        {
            return (this.var_5261);
        }

        public function get itemCategory():int
        {
            return (this.var_3827);
        }

        public function set status(param1:int):void
        {
            this.var_2549 = param1;
        }

        public function set data(param1:String):void
        {
            this._data = param1;
        }

        public function set firstClickUserName(param1:String):void
        {
            this.var_3824 = param1;
        }

        public function set giftWasReceived(param1:Boolean):void
        {
            this.var_3825 = param1;
        }

        public function set ownRealName(param1:String):void
        {
            this.var_5261 = param1;
        }

        public function set objectId(param1:int):void
        {
            this.var_1678 = param1;
        }

        public function get campaignID():String
        {
            return (this.var_3826);
        }

        public function set campaignID(param1:String):void
        {
            this.var_3826 = param1;
        }

        public function set itemCategory(param1:int):void
        {
            this.var_3827 = param1;
        }


    }
}