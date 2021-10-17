package com.sulake.room.events
{
    import flash.events.Event;

    public class RoomContentLoadedEvent extends Event 
    {

        public static const var_265:String = "RCLE_SUCCESS";
        public static const var_266:String = "RCLE_FAILURE";
        public static const var_267:String = "RCLE_CANCEL";

        private var var_5501:String;

        public function RoomContentLoadedEvent(param1:String, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            super(param1, param3, param4);
            this.var_5501 = param2;
        }

        public function get contentType():String
        {
            return (this.var_5501);
        }


    }
}