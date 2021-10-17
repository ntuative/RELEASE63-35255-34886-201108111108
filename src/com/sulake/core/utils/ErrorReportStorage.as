package com.sulake.core.utils
{
    public class ErrorReportStorage 
    {

        private static var var_336:Map = new Map();
        private static var var_335:Map = new Map();


        public static function getDebugData():String
        {
            var _loc1_:String = "";
            var _loc2_:int;
            while (_loc2_ < var_335.length)
            {
                if (_loc2_ == 0)
                {
                    _loc1_ = var_335.getWithIndex(_loc2_);
                }
                else
                {
                    _loc1_ = ((_loc1_ + " ** ") + var_335.getWithIndex(_loc2_));
                };
                _loc2_++;
            };
            if (_loc1_.length > 400)
            {
                _loc1_ = _loc1_.substr((_loc1_.length - 400));
            };
            return (_loc1_);
        }

        public static function addDebugData(param1:String, param2:String):void
        {
            var_335.remove(param1);
            var_335.add(param1, param2);
        }

        public static function setParameter(param1:String, param2:String):void
        {
            var_336[param1] = param2;
        }

        public static function getParameter(param1:String):String
        {
            return (var_336[param1]);
        }

        public static function getParameterNames():Array
        {
            return (var_336.getKeys());
        }


    }
}