package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var var_3637:int;
        private var var_3638:Boolean;


        public function get openHour():int
        {
            return (this._openHour);
        }

        public function get openMinute():int
        {
            return (this.var_3637);
        }

        public function get userThrownOutAtClose():Boolean
        {
            return (this.var_3638);
        }

        public function flush():Boolean
        {
            this._openHour = 0;
            this.var_3637 = 0;
            this.var_3638 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._openHour = param1.readInteger();
            this.var_3637 = param1.readInteger();
            this.var_3638 = (param1.readInteger() > 0);
            return (true);
        }


    }
}