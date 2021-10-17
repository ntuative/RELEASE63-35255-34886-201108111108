package com.sulake.habbo.communication.messages.parser.room.furniture
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RequestSpamWallPostItMessageParser implements IMessageParser 
    {

        private var var_3608:int;
        private var var_2957:String;


        public function get itemId():int
        {
            return (this.var_3608);
        }

        public function get location():String
        {
            return (this.var_2957);
        }

        public function flush():Boolean
        {
            this.var_3608 = -1;
            this.var_2957 = "";
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            if (param1 == null)
            {
                return (false);
            };
            this.var_3608 = param1.readInteger();
            this.var_2957 = param1.readString();
            return (true);
        }


    }
}