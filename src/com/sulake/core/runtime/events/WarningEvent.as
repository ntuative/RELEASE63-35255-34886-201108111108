package com.sulake.core.runtime.events
{
    import flash.events.Event;

    public class WarningEvent extends Event 
    {

        protected var _message:String;

        public function WarningEvent(param1:String, param2:String)
        {
            this._message = ((param2 == null) ? "undefined" : param2);
            super(param1);
        }

        public function get message():String
        {
            return (this._message);
        }


    }
}