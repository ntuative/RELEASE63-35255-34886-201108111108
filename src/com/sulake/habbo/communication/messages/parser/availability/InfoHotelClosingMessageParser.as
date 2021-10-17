package com.sulake.habbo.communication.messages.parser.availability
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoHotelClosingMessageParser implements IMessageParser 
    {

        private var var_3639:int;


        public function get minutesUntilClosing():int
        {
            return (this.var_3639);
        }

        public function flush():Boolean
        {
            this.var_3639 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3639 = param1.readInteger();
            return (true);
        }


    }
}