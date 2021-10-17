package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionFavouriteGroupUpdateEvent extends RoomSessionEvent 
    {

        public static const var_1855:String = "rsfgue_favourite_group_update";

        private var var_3804:int;
        private var var_3805:int;
        private var var_2549:int;

        public function RoomSessionFavouriteGroupUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:Boolean=false, param6:Boolean=false)
        {
            super(var_1855, param1, param5, param6);
            this.var_3804 = param2;
            this.var_3805 = param3;
            this.var_2549 = param4;
        }

        public function get roomIndex():int
        {
            return (this.var_3804);
        }

        public function get habboGroupId():int
        {
            return (this.var_3805);
        }

        public function get status():int
        {
            return (this.var_2549);
        }


    }
}