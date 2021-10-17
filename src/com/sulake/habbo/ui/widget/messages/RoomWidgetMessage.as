package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetMessage 
    {

        public static const var_1560:String = "RWM_MESSAGE_TEST";

        private var _type:String = "";

        public function RoomWidgetMessage(param1:String)
        {
            this._type = param1;
        }

        public function get type():String
        {
            return (this._type);
        }


    }
}