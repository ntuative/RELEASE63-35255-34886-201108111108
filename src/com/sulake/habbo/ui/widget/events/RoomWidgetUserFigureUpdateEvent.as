package com.sulake.habbo.ui.widget.events
{
    import flash.display.BitmapData;

    public class RoomWidgetUserFigureUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1704:String = "RWUTUE_USER_FIGURE";

        private var _userId:int;
        private var var_1033:BitmapData;
        private var var_5263:Boolean;
        private var var_3821:String = "";
        private var var_3548:int;

        public function RoomWidgetUserFigureUpdateEvent(param1:int, param2:BitmapData, param3:Boolean, param4:String, param5:int, param6:Boolean=false, param7:Boolean=false)
        {
            super(var_1704, param6, param7);
            this._userId = param1;
            this.var_1033 = param2;
            this.var_5263 = param3;
            this.var_3821 = param4;
            this.var_3548 = param5;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get image():BitmapData
        {
            return (this.var_1033);
        }

        public function get isOwnUser():Boolean
        {
            return (this.var_5263);
        }

        public function get customInfo():String
        {
            return (this.var_3821);
        }

        public function get achievementScore():int
        {
            return (this.var_3548);
        }


    }
}