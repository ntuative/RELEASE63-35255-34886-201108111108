package com.sulake.core.utils
{
    import flash.text.Font;
    import flash.utils.getQualifiedClassName;

    public class FontEnum 
    {

        private static const var_1116:Map = new Map();
        private static const var_1117:Map = new Map();
        private static var var_1118:Boolean = false;

        {
            init();
        }


        public static function isSystemFont(param1:String):Boolean
        {
            return (!(var_1116.getValue(param1) == null));
        }

        public static function isEmbeddedFont(param1:String):Boolean
        {
            return (!(var_1117.getValue(param1) == null));
        }

        public static function get systemFonts():Map
        {
            return (var_1116);
        }

        public static function get embeddedFonts():Map
        {
            return (var_1117);
        }

        public static function registerFont(param1:Class):Font
        {
            var _loc4_:Font;
            Font.registerFont((param1 as Class));
            var _loc2_:String = getQualifiedClassName(param1);
            var _loc3_:Array = Font.enumerateFonts(false);
            var _loc5_:int = _loc3_.length;
            var _loc6_:int = _loc5_;
            while (_loc6_ > 0)
            {
                _loc4_ = _loc3_[(_loc6_ - 1)];
                if (getQualifiedClassName(_loc4_) == _loc2_) break;
                _loc6_--;
            };
            var_1117.add(_loc4_.fontName, _loc4_);
            return (_loc4_);
        }

        private static function init():void
        {
            var _loc1_:Array;
            var _loc2_:Array;
            var _loc3_:Font;
            if (!var_1118)
            {
                _loc1_ = Font.enumerateFonts(true);
                _loc2_ = Font.enumerateFonts(false);
                for each (_loc3_ in _loc1_)
                {
                    if (_loc2_.indexOf(_loc3_) == -1)
                    {
                        var_1116.add(_loc3_.fontName, _loc3_);
                    };
                };
                var_1118 = true;
            };
        }

        public static function refresh():void
        {
            var _loc2_:Font;
            var _loc3_:Font;
            var _loc1_:Array = Font.enumerateFonts(false);
            var _loc4_:int = _loc1_.length;
            var _loc5_:int;
            while (_loc5_ < _loc4_)
            {
                _loc2_ = _loc1_[_loc5_];
                _loc3_ = var_1117.getValue(_loc2_.fontName);
                if ((((!(_loc3_)) || (!(_loc3_.fontType == _loc2_.fontType))) || (!(_loc3_.fontStyle == _loc2_.fontStyle))))
                {
                    var_1117.add(_loc2_.fontName, _loc2_);
                };
                _loc5_++;
            };
        }


    }
}