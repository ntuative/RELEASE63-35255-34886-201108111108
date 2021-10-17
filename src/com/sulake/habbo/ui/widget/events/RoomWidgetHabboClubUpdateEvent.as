package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_115:String = "RWBIUE_HABBO_CLUB";

        private var var_5249:int = 0;
        private var var_5250:int = 0;
        private var var_5251:int = 0;
        private var var_5252:Boolean = false;
        private var _clubLevel:int;

        public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean=false, param7:Boolean=false)
        {
            super(var_115, param6, param7);
            this.var_5249 = param1;
            this.var_5250 = param2;
            this.var_5251 = param3;
            this.var_5252 = param4;
            this._clubLevel = param5;
        }

        public function get daysLeft():int
        {
            return (this.var_5249);
        }

        public function get periodsLeft():int
        {
            return (this.var_5250);
        }

        public function get pastPeriods():int
        {
            return (this.var_5251);
        }

        public function get allowClubDances():Boolean
        {
            return (this.var_5252);
        }

        public function get clubLevel():int
        {
            return (this._clubLevel);
        }


    }
}