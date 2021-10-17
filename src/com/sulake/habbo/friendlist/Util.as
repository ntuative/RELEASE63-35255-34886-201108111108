package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;

    public class Util 
    {


        public static function remove(param1:Array, param2:Object):void
        {
            var _loc3_:int = param1.indexOf(param2);
            if (_loc3_ >= 0)
            {
                param1.splice(_loc3_, 1);
            };
        }

        public static function getLowestPoint(param1:IWindowContainer):int
        {
            var _loc4_:IWindow;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if (_loc4_.visible)
                {
                    _loc2_ = Math.max(_loc2_, (_loc4_.y + _loc4_.height));
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        public static function getRightmostPoint(param1:IWindowContainer):int
        {
            var _loc4_:IWindow;
            var _loc2_:int;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if (_loc4_.visible)
                {
                    _loc2_ = Math.max(_loc2_, (_loc4_.x + _loc4_.width));
                };
                _loc3_++;
            };
            return (_loc2_);
        }

        public static function arrayToString(param1:Array, param2:String=", ", param3:String=""):String
        {
            var _loc5_:Object;
            var _loc4_:String = "";
            for each (_loc5_ in param1)
            {
                if (_loc4_ != "")
                {
                    _loc4_ = (_loc4_ + param2);
                };
                _loc4_ = (_loc4_ + ((param3 + _loc5_) + param3));
            };
            return (_loc4_);
        }

        public static function print(param1:String, param2:IWindow):void
        {
            var _loc4_:int;
            Logger.log((((((((param1 + param2) + " (") + param2.width) + ", ") + param2.height) + "), ") + param2.getParamFlag(HabboWindowParam.var_159)));
            var _loc3_:IWindowContainer = (param2 as IWindowContainer);
            if (_loc3_ != null)
            {
                _loc4_ = 0;
                while (_loc4_ < _loc3_.numChildren)
                {
                    print((param1 + "-"), _loc3_.getChildAt(_loc4_));
                    _loc4_++;
                };
            };
        }

        public static function hideChildren(param1:IWindowContainer):void
        {
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                param1.getChildAt(_loc2_).visible = false;
                _loc2_++;
            };
        }

        public static function getLocationRelativeTo(param1:IWindow, param2:int, param3:int):Rectangle
        {
            if (param1 == null)
            {
                return (new Rectangle(300, 200, param2, param3));
            };
            var _loc4_:int = (param1.width - param2);
            var _loc5_:int = (param1.height - param3);
            return (new Rectangle((param1.x + (0.5 * _loc4_)), (param1.y + (0.5 * _loc5_)), param2, param3));
        }

        public static function layoutChildrenInArea(param1:IWindowContainer, param2:int, param3:int):void
        {
            var _loc7_:IWindow;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            while (_loc6_ < param1.numChildren)
            {
                _loc7_ = param1.getChildAt(_loc6_);
                if (_loc7_.visible)
                {
                    if (((_loc4_ > 0) && ((_loc4_ + _loc7_.width) > param2)))
                    {
                        _loc4_ = 0;
                        _loc5_ = (_loc5_ + param3);
                    };
                    _loc7_.x = _loc4_;
                    _loc7_.y = _loc5_;
                    _loc4_ = (_loc4_ + _loc7_.width);
                };
                _loc6_++;
            };
        }


    }
}