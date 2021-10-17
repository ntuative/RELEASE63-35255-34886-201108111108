package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_2338:String = "RWULUE_USER_LOCATION_UPDATE";

        private var _userId:int;
        private var var_2737:Rectangle;
        private var var_5276:Point;

        public function RoomWidgetUserLocationUpdateEvent(param1:int, param2:Rectangle, param3:Point, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_2338, param4, param5);
            this._userId = param1;
            this.var_2737 = param2;
            this.var_5276 = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get rectangle():Rectangle
        {
            return (this.var_2737);
        }

        public function get screenLocation():Point
        {
            return (this.var_5276);
        }


    }
}