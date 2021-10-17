package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInfoUpdatedMessageParser implements IMessageParser 
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