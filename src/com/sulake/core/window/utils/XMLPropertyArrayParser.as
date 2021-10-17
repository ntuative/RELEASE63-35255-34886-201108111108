package com.sulake.core.window.utils
{
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.utils.Map;

    public class XMLPropertyArrayParser extends XMLVariableParser 
    {


        public static function parse(param1:XMLList):Array
        {
            var _loc5_:int;
            var _loc2_:Map = new Map();
            var _loc3_:Array = new Array();
            var _loc4_:Array = new Array();
            _loc5_ = XMLVariableParser.parseVariableList(param1, _loc2_, _loc3_);
            var _loc6_:int;
            while (_loc6_ < _loc5_)
            {
                _loc4_.push(new PropertyStruct(_loc2_.getKey(_loc6_), _loc2_.getWithIndex(_loc6_), _loc3_[_loc6_], true));
                _loc6_++;
            };
            return (_loc4_);
        }


    }
}