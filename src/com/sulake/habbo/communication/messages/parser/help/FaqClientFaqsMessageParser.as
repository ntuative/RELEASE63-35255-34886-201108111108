package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqClientFaqsMessageParser implements IMessageParser 
    {

        private var var_3696:Map;
        private var var_3697:Map;


        public function get urgentData():Map
        {
            return (this.var_3696);
        }

        public function get normalData():Map
        {
            return (this.var_3697);
        }

        public function flush():Boolean
        {
            if (this.var_3696 != null)
            {
                this.var_3696.dispose();
            };
            this.var_3696 = null;
            if (this.var_3697 != null)
            {
                this.var_3697.dispose();
            };
            this.var_3697 = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:String;
            var _loc4_:int;
            var _loc5_:int;
            this.var_3696 = new Map();
            this.var_3697 = new Map();
            _loc5_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc5_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                this.var_3696.add(_loc2_, _loc3_);
                _loc4_++;
            };
            _loc5_ = param1.readInteger();
            _loc4_ = 0;
            while (_loc4_ < _loc5_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                this.var_3697.add(_loc2_, _loc3_);
                _loc4_++;
            };
            return (true);
        }


    }
}