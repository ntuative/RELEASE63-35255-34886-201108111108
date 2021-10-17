package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage 
    {

        public static const var_2268:String = "select_outfit";

        private var var_5387:int;

        public function RoomWidgetSelectOutfitMessage(param1:int)
        {
            super(var_2268);
            this.var_5387 = param1;
        }

        public function get outfitId():int
        {
            return (this.var_5387);
        }


    }
}