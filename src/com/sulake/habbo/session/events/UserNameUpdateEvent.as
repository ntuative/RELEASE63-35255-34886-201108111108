package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class UserNameUpdateEvent extends Event 
    {

        public static const var_1753:String = "unue_name_updated";

        private var _name:String;

        public function UserNameUpdateEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(var_1753, param2, param3);
            this._name = param1;
        }

        public function get name():String
        {
            return (this._name);
        }


    }
}