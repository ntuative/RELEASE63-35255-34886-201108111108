package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IdentityAccountsMessageParser implements IMessageParser 
    {

        private var var_3674:Map;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3674 = new Map();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_3674.add(param1.readInteger(), param1.readString());
                _loc3_++;
            };
            return (true);
        }

        public function get accounts():Map
        {
            return (this.var_3674);
        }


    }
}