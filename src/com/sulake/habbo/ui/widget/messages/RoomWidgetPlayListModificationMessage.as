package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage 
    {

        public static const var_1589:String = "RWPLAM_ADD_TO_PLAYLIST";
        public static const var_1590:String = "RWPLAM_REMOVE_FROM_PLAYLIST";

        private var var_5384:int;
        private var var_5385:int;

        public function RoomWidgetPlayListModificationMessage(param1:String, param2:int=-1, param3:int=-1)
        {
            super(param1);
            this.var_5385 = param2;
            this.var_5384 = param3;
        }

        public function get diskId():int
        {
            return (this.var_5384);
        }

        public function get slotNumber():int
        {
            return (this.var_5385);
        }


    }
}