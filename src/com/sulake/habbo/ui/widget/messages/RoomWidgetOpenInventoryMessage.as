package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage 
    {

        public static const var_2261:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
        public static const var_2277:String = "inventory_effects";
        public static const var_2278:String = "inventory_badges";
        public static const var_2280:String = "inventory_clothes";
        public static const var_2279:String = "inventory_furniture";

        private var var_5383:String;

        public function RoomWidgetOpenInventoryMessage(param1:String)
        {
            super(var_2261);
            this.var_5383 = param1;
        }

        public function get inventoryType():String
        {
            return (this.var_5383);
        }


    }
}