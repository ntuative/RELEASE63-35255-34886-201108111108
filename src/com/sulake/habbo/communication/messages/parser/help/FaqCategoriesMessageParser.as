package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqCategoriesMessageParser implements IMessageParser 
    {

        private var _data:Map;


        public function get data():Map
        {
            return (this._data);
        }

        public function flush():Boolean
        {
            if (this._data != null)
            {
                this._data.dispose();
            };
            this._data = null;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:Map;
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:int;
            this._data = new Map();
            var _loc6_:int = param1.readInteger();
            var _loc7_:int;
            while (_loc7_ < _loc6_)
            {
                _loc2_ = new Map();
                _loc3_ = param1.readInteger();
                _loc4_ = param1.readString();
                _loc5_ = param1.readInteger();
                _loc2_.add("name", _loc4_);
                _loc2_.add("count", _loc5_);
                this._data.add(_loc3_, _loc2_);
                _loc7_++;
            };
            return (true);
        }


    }
}