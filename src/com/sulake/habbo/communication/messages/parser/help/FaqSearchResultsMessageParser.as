package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FaqSearchResultsMessageParser implements IMessageParser 
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
            var _loc2_:int;
            var _loc3_:String;
            this._data = new Map();
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = param1.readString();
                this._data.add(_loc2_, _loc3_);
                _loc5_++;
            };
            return (true);
        }


    }
}