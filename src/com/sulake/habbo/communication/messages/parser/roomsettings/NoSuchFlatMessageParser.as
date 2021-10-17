package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NoSuchFlatMessageParser implements IMessageParser 
    {

        private var var_3465:int;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }


    }
}