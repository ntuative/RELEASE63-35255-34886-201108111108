package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class BadgeImageReadyEvent extends Event 
    {

        public static const var_100:String = "BIRE_BADGE_IMAGE_READY";

        private var var_3417:String;
        private var var_1033:BitmapData;

        public function BadgeImageReadyEvent(param1:String, param2:BitmapData, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_100, param3, param4);
            this.var_3417 = param1;
            this.var_1033 = param2;
        }

        public function get badgeId():String
        {
            return (this.var_3417);
        }

        public function get badgeImage():BitmapData
        {
            return (this.var_1033);
        }


    }
}