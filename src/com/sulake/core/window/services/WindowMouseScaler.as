package com.sulake.core.window.services
{
    import flash.display.DisplayObject;
    import com.sulake.core.window.enum.WindowParam;

    public class WindowMouseScaler extends WindowMouseOperator implements IMouseScalingService 
    {

        public function WindowMouseScaler(param1:DisplayObject)
        {
            super(param1);
        }

        override public function operate(param1:int, param2:int):void
        {
            var _loc3_:int;
            var _loc4_:int;
            if (!_window.disposed)
            {
                _loc3_ = ((var_2492 & WindowParam.var_693) ? (param1 - _mouse.x) : 0);
                _loc4_ = ((var_2492 & WindowParam.var_694) ? (param2 - _mouse.y) : 0);
                _window.scale(_loc3_, _loc4_);
            };
        }


    }
}