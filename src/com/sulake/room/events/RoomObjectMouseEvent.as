package com.sulake.room.events
{
    public class RoomObjectMouseEvent extends RoomObjectEvent 
    {

        public static const var_496:String = "ROE_MOUSE_CLICK";
        public static const var_387:String = "ROE_MOUSE_ENTER";
        public static const var_497:String = "ROE_MOUSE_MOVE";
        public static const var_388:String = "ROE_MOUSE_LEAVE";
        public static const var_1824:String = "ROE_MOUSE_DOUBLE_CLICK";
        public static const var_498:String = "ROE_MOUSE_DOWN";

        private var var_5502:String = "";
        private var var_5503:Boolean;
        private var var_5504:Boolean;
        private var var_5505:Boolean;
        private var var_5506:Boolean;

        public function RoomObjectMouseEvent(param1:String, param2:String, param3:int, param4:String, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false, param8:Boolean=false, param9:Boolean=false, param10:Boolean=false)
        {
            super(param1, param3, param4, param9, param10);
            this.var_5502 = param2;
            this.var_5503 = param5;
            this.var_5504 = param6;
            this.var_5505 = param7;
            this.var_5506 = param8;
        }

        public function get eventId():String
        {
            return (this.var_5502);
        }

        public function get altKey():Boolean
        {
            return (this.var_5503);
        }

        public function get ctrlKey():Boolean
        {
            return (this.var_5504);
        }

        public function get shiftKey():Boolean
        {
            return (this.var_5505);
        }

        public function get buttonDown():Boolean
        {
            return (this.var_5506);
        }


    }
}