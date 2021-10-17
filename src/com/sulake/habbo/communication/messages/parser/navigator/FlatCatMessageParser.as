package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCatMessageParser implements IMessageParser 
    {

        private var var_3465:int;
        private var var_3472:int;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            this.var_3472 = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            this.var_3465 = 0;
            this.var_3472 = 0;
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get nodeId():int
        {
            return (this.var_3472);
        }


    }
}