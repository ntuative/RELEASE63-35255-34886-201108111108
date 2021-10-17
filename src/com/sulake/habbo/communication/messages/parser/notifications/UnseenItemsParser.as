package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UnseenItemsParser implements IMessageParser 
    {

        private var _items:Map;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            var _loc2_:int;
            var _loc3_:Array;
            var _loc6_:int;
            var _loc7_:int;
            this._items = new Map();
            var _loc4_:int = param1.readInteger();
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = param1.readInteger();
                _loc3_ = [];
                _loc6_ = param1.readInteger();
                _loc7_ = 0;
                while (_loc7_ < _loc6_)
                {
                    _loc3_.push(param1.readInteger());
                    _loc7_++;
                };
                this._items.add(_loc2_, _loc3_);
                _loc5_++;
            };
            return (true);
        }

        public function getCategories():Array
        {
            return (this._items.getKeys());
        }

        public function getItemsByCategory(param1:int):Array
        {
            return (this._items.getValue(param1));
        }


    }
}