package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserFlatCatsMessageParser implements IMessageParser 
    {

        private var var_3387:Array;


        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3387 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3387.push(new FlatCategory(param1));
                _loc3_++;
            };
            return (true);
        }

        public function flush():Boolean
        {
            this.var_3387 = null;
            return (true);
        }

        public function get nodes():Array
        {
            return (this.var_3387);
        }


    }
}