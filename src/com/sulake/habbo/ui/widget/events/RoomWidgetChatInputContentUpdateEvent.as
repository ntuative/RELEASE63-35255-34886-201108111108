package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetChatInputContentUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1640:String = "RWWCIDE_CHAT_INPUT_CONTENT";
        public static const var_1643:String = "whisper";
        public static const var_1644:String = "shout";

        private var var_5238:String = "";
        private var _userName:String = "";

        public function RoomWidgetChatInputContentUpdateEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(var_1640, param3, param4);
            this.var_5238 = param1;
            this._userName = param2;
        }

        public function get messageType():String
        {
            return (this.var_5238);
        }

        public function get userName():String
        {
            return (this._userName);
        }


    }
}