package com.sulake.habbo.advertisement.events
{
    import flash.events.Event;
    import flash.display.BitmapData;

    public class InterstitialEvent extends Event 
    {

        public static const var_339:String = "AE_INTERSTITIAL_SHOW";
        public static const var_338:String = "AE_INTERSTITIAL_COMPLETE";

        private var var_1033:BitmapData;
        private var var_2824:String;

        public function InterstitialEvent(param1:String, param2:BitmapData=null, param3:String="", param4:Boolean=false, param5:Boolean=false)
        {
            super(param1, param4, param5);
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function get clickURL():String
        {
            return (this.var_2824);
        }


    }
}