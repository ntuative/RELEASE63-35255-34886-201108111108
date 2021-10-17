package com.sulake.room.utils
{
    public class XMLValidator 
    {


        public static function checkRequiredAttributes(param1:Object, param2:Array):Boolean
        {
            var _loc4_:XML;
            var _loc5_:XMLList;
            if (((param1 == null) || (param2 == null)))
            {
                return (false);
            };
            var _loc3_:int;
            if ((param1 is XML))
            {
                _loc4_ = (param1 as XML);
                _loc3_ = 0;
                while (_loc3_ < param2.length)
                {
                    if (_loc4_.attribute(String(param2[_loc3_])).length() == 0)
                    {
                        return (false);
                    };
                    _loc3_++;
                };
            }
            else
            {
                if ((param1 is XMLList))
                {
                    _loc5_ = (param1 as XMLList);
                    _loc3_ = 0;
                    while (_loc3_ < param2.length)
                    {
                        if (_loc4_.attribute(String(param2[_loc3_])).length() == 0)
                        {
                            return (false);
                        };
                        _loc3_++;
                    };
                }
                else
                {
                    return (false);
                };
            };
            return (true);
        }


    }
}