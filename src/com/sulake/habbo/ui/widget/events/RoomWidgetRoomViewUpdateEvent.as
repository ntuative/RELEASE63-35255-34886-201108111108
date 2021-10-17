package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1538:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
        public static const var_1654:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
        public static const var_1653:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";

        private var var_5257:Rectangle;
        private var var_5258:Point;
        private var _scale:Number = 0;

        public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle=null, param3:Point=null, param4:Number=0, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_5257 = param2;
            this.var_5258 = param3;
            this._scale = param4;
        }

        public function get rect():Rectangle
        {
            if (this.var_5257 != null)
            {
                return (this.var_5257.clone());
            };
            return (null);
        }

        public function get positionDelta():Point
        {
            if (this.var_5258 != null)
            {
                return (this.var_5258.clone());
            };
            return (null);
        }

        public function get scale():Number
        {
            return (this._scale);
        }


    }
}