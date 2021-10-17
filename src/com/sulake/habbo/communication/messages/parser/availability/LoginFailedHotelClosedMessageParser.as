package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class LoginFailedHotelClosedMessageParser implements IMessageParser 
    {

        private var _openHour:int;
        private var var_3637:int;


        public function get openHour():int
        {
            return (this._openHour);
        }

        public function get openMinute():int
        {
            return (this.var_3637);
        }

        public function flush():Boolean
        {
            this._openHour = 0;
            this.var_3637 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._openHour = param1.readInteger();
            this.var_3637 = param1.readInteger();
            return (true);
        }


    }
}