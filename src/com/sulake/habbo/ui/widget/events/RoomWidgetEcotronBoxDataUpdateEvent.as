package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetEcotronBoxDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1618:String = "RWEBDUE_PACKAGEINFO";
        public static const var_1619:String = "RWEBDUE_CONTENTS";

        private var var_1678:int = -1;
        private var _text:String;
        private var var_2438:Boolean;
        private var var_5246:BitmapData;

        public function RoomWidgetEcotronBoxDataUpdateEvent(param1:String, param2:int, param3:String, param4:Boolean=false, param5:BitmapData=null, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_1678 = param2;
            this._text = param3;
            this.var_2438 = param4;
            this.var_5246 = param5;
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get text():String
        {
            return (this._text);
        }

        public function get controller():Boolean
        {
            return (this.var_2438);
        }

        public function get iconBitmapData():BitmapData
        {
            return (this.var_5246);
        }


    }
}