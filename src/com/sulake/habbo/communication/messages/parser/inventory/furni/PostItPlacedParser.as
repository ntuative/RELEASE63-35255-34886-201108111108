package com.sulake.habbo.communication.messages.parser.inventory.furni
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PostItPlacedParser implements IMessageParser 
    {

        private var _id:int;
        private var var_3714:int;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._id = param1.readInteger();
            this.var_3714 = param1.readInteger();
            return (true);
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get itemsLeft():int
        {
            return (this.var_3714);
        }


    }
}