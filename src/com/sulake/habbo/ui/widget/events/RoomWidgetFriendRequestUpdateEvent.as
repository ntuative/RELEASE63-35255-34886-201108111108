package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetFriendRequestUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1593:String = "RWFRUE_SHOW_FRIEND_REQUEST";
        public static const var_1594:String = "RWFRUE_HIDE_FRIEND_REQUEST";

        private var var_3405:int;
        private var _userId:int;
        private var _userName:String;

        public function RoomWidgetFriendRequestUpdateEvent(param1:String, param2:int, param3:int=0, param4:String=null, param5:Boolean=false, param6:Boolean=false)
        {
            super(param1, param5, param6);
            this.var_3405 = param2;
            this._userId = param3;
            this._userName = param4;
        }

        public function get requestId():int
        {
            return (this.var_3405);
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get userName():String
        {
            return (this._userName);
        }


    }
}