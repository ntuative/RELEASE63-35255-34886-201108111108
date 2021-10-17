package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCreatedMessageParser implements IMessageParser 
    {

        private var var_3465:int;
        private var var_3764:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            this.var_3764 = param1.readString();
            Logger.log(((("FLAT CREATED: " + this.var_3465) + ", ") + this.var_3764));
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get flatName():String
        {
            return (this.var_3764);
        }


    }
}