package com.sulake.habbo.navigator
{
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import flash.geom.Point;

    public class Util 
    {

        private static var var_1910:CutToWidth = new CutToWidth();
        private static var var_4375:CutToHeight = new CutToHeight();


        public static function remove(param1:Array, param2:Object):int
        {
            var _loc3_:int = param1.indexOf(param2);
            if (_loc3_ >= 0)
            {
                param1.splice(_loc3_, 1);
            };
            return (_loc3_);
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

        public static function hasVisibleChildren(param1:IWindowContainer):Boolean
        {
            var _loc3_:IWindow;
            var _loc2_:int;
            while (_loc2_ < param1.numChildren)
            {
                _loc3_ = param1.getChildAt(_loc2_);
                if (_loc3_.visible)
                {
                    return (true);
                };
                _loc2_++;
            };
            return (false);
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

        public static function moveChildrenToRow(param1:IWindowContainer, param2:Array, param3:int, param4:int, param5:int):void
        {
            var _loc6_:String;
            var _loc7_:IWindow;
            for each (_loc6_ in param2)
            {
                _loc7_ = param1.getChildByName(_loc6_);
                if (((!(_loc7_ == null)) && (_loc7_.visible)))
                {
                    _loc7_.x = param3;
                    _loc7_.y = param4;
                    param3 = (param3 + (_loc7_.width + param5));
                };
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

        public static function layoutChildrenInArea(param1:IWindowContainer, param2:int, param3:int, param4:int=0):void
        {
            var _loc8_:IWindow;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            while (_loc7_ < param1.numChildren)
            {
                _loc8_ = param1.getChildAt(_loc7_);
                if (_loc8_.visible)
                {
                    if (((_loc5_ > 0) && ((_loc5_ + _loc8_.width) > param2)))
                    {
                        _loc5_ = 0;
                        _loc6_ = (_loc6_ + param3);
                    };
                    _loc8_.x = _loc5_;
                    _loc8_.y = _loc6_;
                    _loc5_ = (_loc5_ + (_loc8_.width + param4));
                };
                _loc7_++;
            };
        }

        public static function setProc(param1:IWindowContainer, param2:String, param3:Function):void
        {
            var _loc4_:IWindow = param1.findChildByName(param2);
            _loc4_.setParamFlag(HabboWindowParam.var_158, true);
            _loc4_.procedure = param3;
        }

        public static function setProcDirectly(param1:IWindow, param2:Function):void
        {
            param1.setParamFlag(HabboWindowParam.var_158, true);
            param1.procedure = param2;
        }

        public static function setColors(param1:IWindowContainer, param2:uint):void
        {
            var _loc4_:IWindow;
            var _loc3_:int;
            while (_loc3_ < param1.numChildren)
            {
                _loc4_ = param1.getChildAt(_loc3_);
                if ((_loc4_ as IWindowContainer) != null)
                {
                    setColors(IWindowContainer(_loc4_), param2);
                }
                else
                {
                    if (!(_loc4_ as IRadioButtonWindow))
                    {
                        if ((_loc4_ as ITextFieldWindow))
                        {
                            ITextFieldWindow(_loc4_).textColor = param2;
                            ITextFieldWindow(_loc4_).borderColor = param2;
                        }
                        else
                        {
                            if ((_loc4_ as ITextWindow))
                            {
                                ITextWindow(_loc4_).textColor = param2;
                            }
                            else
                            {
                                if ((_loc4_ as IButtonWindow))
                                {
                                    IButtonWindow(_loc4_).style = 0;
                                };
                            };
                        };
                    };
                };
                _loc3_++;
            };
        }

        public static function trim(param1:String):String
        {
            if (((param1 == null) || (param1.length < 1)))
            {
                return (param1);
            };
            while (param1.charAt(0) == " ")
            {
                param1 = param1.substring(1);
            };
            while (param1.charAt((param1.length - 1)) == " ")
            {
                param1 = param1.substring(0, (param1.length - 1));
            };
            return (param1);
        }

        public static function cutTextToWidth(param1:ITextWindow, param2:String, param3:int):void
        {
            param1.text = param2;
            if (param1.textWidth <= param3)
            {
                return;
            };
            var_1910.beforeSearch(param2, param1, param3);
            binarySearch(var_1910, (param2.length - 1));
        }

        public static function binarySearch(param1:BinarySearchTest, param2:int):void
        {
            var _loc5_:int;
            var _loc6_:Boolean;
            var _loc3_:int;
            var _loc4_:int;
            while (true)
            {
                if (_loc3_ >= param2)
                {
                    param1.test(_loc4_);
                    return;
                };
                _loc5_ = int((_loc3_ + Math.floor(((param2 - _loc3_) / 2))));
                _loc6_ = param1.test(_loc5_);
                if (_loc6_)
                {
                    param2 = (_loc5_ - 1);
                }
                else
                {
                    _loc4_ = Math.max(_loc4_, _loc5_);
                    _loc3_ = (_loc5_ + 1);
                };
            };
        }

        public static function containsMouse(param1:IWindow):Boolean
        {
            var _loc2_:Point = new Point();
            param1.getRelativeMousePosition(_loc2_);
            var _loc3_:Boolean = ((((_loc2_.x >= 0) && (_loc2_.y >= 0)) && (_loc2_.x < param1.width)) && (_loc2_.y < param1.height));
            Logger.log(((((("CHECKINg: " + _loc2_) + ", ") + param1.rectangle) + ", ") + _loc3_));
            return (_loc3_);
        }


    }
}