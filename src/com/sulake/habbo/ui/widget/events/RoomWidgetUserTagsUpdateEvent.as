package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetUserTagsUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1703:String = "RWUTUE_USER_TAGS";

        private var _userId:int;
        private var var_1209:Array;
        private var var_5263:Boolean;

        public function RoomWidgetUserTagsUpdateEvent(param1:int, param2:Array, param3:Boolean, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_1703, param4, param5);
            this._userId = param1;
            this.var_1209 = param2;
            this.var_5263 = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get tags():Array
        {
            return (this.var_1209);
        }

        public function get isOwnUser():Boolean
        {
            return (this.var_5263);
        }


    }
}