package com.sulake.habbo.messenger
{
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;

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

        public static function getFormattedNow():String
        {
            var _loc1_:Date = new Date();
            return ((pad(true, "0", 2, ("" + _loc1_.hours)) + ":") + pad(true, "0", 2, ("" + _loc1_.minutes)));
        }

        public static function pad(param1:Boolean, param2:String, param3:int, param4:String):String
        {
            var _loc5_:String = param4;
            while (_loc5_.length < param3)
            {
                if (param1)
                {
                    _loc5_ = (param2 + _loc5_);
                }
                else
                {
                    _loc5_ = (_loc5_ + param2);
                };
            };
            return (_loc5_);
        }

        public static function getContainer(param1:IHabboWindowManager, param2:String, param3:int, param4:int, param5:Boolean):IWindowContainer
        {
            return (param1.createWindow(param2, param2, HabboWindowType.var_218, HabboWindowStyle.var_613, (HabboWindowParam.var_158 | ((param5) ? HabboWindowParam.var_159 : 0)), new Rectangle(param3, param4, 600, 600), null) as IWindowContainer);
        }


    }
}