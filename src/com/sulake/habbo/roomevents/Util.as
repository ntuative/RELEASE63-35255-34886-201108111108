package com.sulake.habbo.roomevents
{
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Util 
    {


        public static function setProcDirectly(param1:IWindow, param2:Function):void
        {
            param1.setParamFlag(HabboWindowParam.var_158, true);
            param1.procedure = param2;
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

        public static function hideChildren(param1:IWindowContainer):void
        {
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                param1.getChildAt(_loc2_).visible = false;
                _loc2_++;
            };
        }

        public static function showChildren(param1:IWindowContainer):void
        {
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                param1.getChildAt(_loc2_).visible = true;
                _loc2_++;
            };
        }

        public static function moveChildrenToColumn(param1:IWindowContainer, param2:Array, param3:int, param4:int):void
        {
            var _loc5_:String;
            var _loc6_:IWindow;
            for each (_loc5_ in param2)
            {
                _loc6_ = param1.getChildByName(_loc5_);
                if ((((!(_loc6_ == null)) && (_loc6_.visible)) && (_loc6_.height > 0)))
                {
                    _loc6_.y = param3;
                    param3 = (param3 + (_loc6_.height + param4));
                };
            };
        }

        public static function moveAllChildrenToColumn(param1:IWindowContainer, param2:int, param3:int):void
        {
            var _loc4_:int;
            var _loc5_:IWindow;
            while (_loc4_ < param1.numChildren)
            {
                _loc5_ = param1.getChildAt(_loc4_);
                if ((((!(_loc5_ == null)) && (_loc5_.visible)) && (_loc5_.height > 0)))
                {
                    _loc5_.y = param2;
                    param2 = (param2 + (_loc5_.height + param3));
                };
                _loc4_++;
            };
        }


    }
}