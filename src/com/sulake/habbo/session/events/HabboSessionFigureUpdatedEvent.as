package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class HabboSessionFigureUpdatedEvent extends Event 
    {

        public static const var_1412:String = "HABBO_SESSION_FIGURE_UPDATE";

        private var _userId:int;
        private var var_2994:String;
        private var var_2938:String;

        public function HabboSessionFigureUpdatedEvent(param1:int, param2:String, param3:String, param4:Boolean=false, param5:Boolean=false)
        {
            super(var_1412, param4, param5);
            this._userId = param1;
            this.var_2994 = param2;
            this.var_2938 = param3;
        }

        public function get userId():int
        {
            return (this._userId);
        }

        public function get figure():String
        {
            return (this.var_2994);
        }

        public function get gender():String
        {
            return (this.var_2938);
        }


    }
}