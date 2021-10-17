package com.sulake.habbo.room.events
{
    public class RoomEngineObjectEvent extends RoomEngineEvent 
    {

        public static const var_382:String = "REOE_OBJECT_SELECTED";
        public static const var_383:String = "REOE_OBJECT_DESELECTED";
        public static const var_384:String = "REOB_OBJECT_ADDED";
        public static const var_385:String = "REOE_OBJECT_REMOVED";
        public static const var_133:String = "REOB_OBJECT_PLACED";
        public static const var_527:String = "REOB_OBJECT_CONTENT_UPDATED";
        public static const var_386:String = "REOB_OBJECT_REQUEST_MOVE";
        public static const var_387:String = "REOB_OBJECT_MOUSE_ENTER";
        public static const var_388:String = "REOB_OBJECT_MOUSE_LEAVE";
        public static const var_394:String = "REOE_WIDGET_REQUEST_PLACEHOLDER";
        public static const ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI:String = "REOE_WIDGET_REQUEST_CREDITFURNI";
        public static const var_389:String = "REOE_WIDGET_REQUEST_STICKIE";
        public static const var_390:String = "REOE_WIDGET_REQUEST_PRESENT";
        public static const var_391:String = "REOE_WIDGET_REQUEST_TROPHY";
        public static const var_392:String = "REOE_WIDGET_REQUEST_TEASER";
        public static const var_393:String = "REOE_WIDGET_REQUEST_ECOTRONBOX";
        public static const var_395:String = "REOE_WIDGET_REQUEST_DIMMER";
        public static const var_400:String = "REOR_REMOVE_DIMMER";
        public static const var_401:String = "REOR_REQUEST_CLOTHING_CHANGE";
        public static const var_402:String = "REOR_WIDGET_REQUEST_PLAYLIST_EDITOR";
        public static const var_396:String = "REOE_ROOM_AD_FURNI_CLICK";
        public static const var_397:String = "REOE_ROOM_AD_FURNI_DOUBLE_CLICK";
        public static const var_398:String = "REOE_ROOM_AD_TOOLTIP_SHOW";
        public static const var_399:String = "REOE_ROOM_AD_TOOLTIP_HIDE";

        private var var_1678:int;
        private var _category:int;

        public function RoomEngineObjectEvent(param1:String, param2:int, param3:int, param4:int, param5:int, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param2, param3, param6, param7);
            this.var_1678 = param4;
            this._category = param5;
        }

        public function get objectId():int
        {
            return (this.var_1678);
        }

        public function get category():int
        {
            return (this._category);
        }


    }
}