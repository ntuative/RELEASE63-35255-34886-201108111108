package com.sulake.habbo.session
{
    import flash.display.BitmapData;

    public class BadgeInfo 
    {

        private var var_1033:BitmapData;
        private var var_4983:Boolean;

        public function BadgeInfo(param1:BitmapData, param2:Boolean)
        {
            this.var_1033 = param1;
            this.var_4983 = param2;
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function get placeHolder():Boolean
        {
            return (this.var_4983);
        }


    }
}