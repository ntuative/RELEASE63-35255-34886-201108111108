package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurniListRemoveParser implements IMessageParser 
    {

        private var var_3608:int;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3608 = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get stripId():int
        {
            return (this.var_3608);
        }


    }
}