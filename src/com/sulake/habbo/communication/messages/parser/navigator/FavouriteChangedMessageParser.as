package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FavouriteChangedMessageParser implements IMessageParser 
    {

        private var var_3465:int;
        private var var_3762:Boolean;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3465 = param1.readInteger();
            this.var_3762 = param1.readBoolean();
            return (true);
        }

        public function get flatId():int
        {
            return (this.var_3465);
        }

        public function get added():Boolean
        {
            return (this.var_3762);
        }


    }
}