package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1677:String = "RWSWPUE_OPEN_EDITOR";

        private var var_1678:int;
        private var var_2957:String;
        private var var_5260:String;

        public function RoomWidgetSpamWallPostItEditEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_1678 = param2;
            this.var_2957 = param3;
            this.var_5260 = param4;
        }

        public function get location():String
        {
            return (this.var_2957);
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get objectType():String
        {
            return (this.var_5260);
        }


    }
}