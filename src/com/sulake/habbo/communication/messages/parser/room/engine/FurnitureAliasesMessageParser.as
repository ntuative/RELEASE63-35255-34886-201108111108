package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FurnitureAliasesMessageParser implements IMessageParser 
    {

        private var var_2859:Map = null;

        public function FurnitureAliasesMessageParser()
        {
            this.var_2859 = new Map();
        }

        public function get aliasCount():int
        {
            return (this.var_2859.length);
        }

        public function getName(param1:int):String
        {
            if (((param1 < 0) || (param1 >= this.aliasCount)))
            {
                return (null);
            };
            return (this.var_2859.getKey(param1));
        }

        public function getAlias(param1:int):String
        {
            if (((param1 < 0) || (param1 >= this.aliasCount)))
            {
                return (null);
            };
            return (this.var_2859.getWithIndex(param1));
        }

        public function flush():Boolean
        {
            this.var_2859.reset();
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc4_:String;
            var _loc5_:String;
            this.var_2859.reset();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc4_ = param1.readString();
                _loc5_ = param1.readString();
                this.var_2859.remove(_loc4_);
                this.var_2859.add(_loc4_, _loc5_);
                _loc3_++;
            };
            return (true);
        }


    }
}