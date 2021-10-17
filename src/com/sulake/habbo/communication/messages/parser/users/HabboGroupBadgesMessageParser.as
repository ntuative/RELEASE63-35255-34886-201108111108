package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupBadgesMessageParser implements IMessageParser 
    {

        protected var var_3862:Map;

        public function HabboGroupBadgesMessageParser()
        {
            this.var_3862 = new Map();
        }

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc3_:int;
            var _loc4_:String;
            this.var_3862.dispose();
            this.var_3862 = new Map();
            var _loc2_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc2_)
            {
                _loc3_ = param1.readInteger();
                _loc4_ = param1.readString();
                this.var_3862.add(_loc3_, _loc4_);
                _loc5_++;
            };
            return (true);
        }

        public function get badges():Map
        {
            var _loc1_:Map = new Map();
            var _loc2_:int;
            while (_loc2_ < this.var_3862.length)
            {
                _loc1_.add(this.var_3862.getKey(_loc2_), this.var_3862.getWithIndex(_loc2_));
                _loc2_++;
            };
            return (_loc1_);
        }


    }
}