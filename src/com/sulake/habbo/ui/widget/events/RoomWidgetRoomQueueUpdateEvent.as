package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_1631:String = "RWRQUE_VISITOR_QUEUE_STATUS";
        public static const var_1632:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";

        private var var_4478:int;
        private var var_5255:Boolean;
        private var var_4064:Boolean;
        private var var_5256:Boolean;

        public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean=false, param7:Boolean=false)
        {
            super(param1, param6, param7);
            this.var_4478 = param2;
            this.var_5255 = param3;
            this.var_4064 = param4;
            this.var_5256 = param5;
        }

        public function get position():int
        {
            return (this.var_4478);
        }

        public function get hasHabboClub():Boolean
        {
            return (this.var_5255);
        }

        public function get isActive():Boolean
        {
            return (this.var_4064);
        }

        public function get isClubQueue():Boolean
        {
            return (this.var_5256);
        }


    }
}