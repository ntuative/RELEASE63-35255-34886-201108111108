package com.sulake.habbo.navigator
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.core.window.enum.*;

    public class UserCountRenderer 
    {

        public static const var_1929:String = "usercount";

        private var _navigator:HabboNavigator;

        public function UserCountRenderer(param1:HabboNavigator)
        {
            this._navigator = param1;
        }

        public function dispose():void
        {
            this._navigator = null;
        }

        public function refreshUserCount(param1:int, param2:IWindowContainer, param3:int, param4:String, param5:int, param6:int):void
        {
            var _loc7_:IWindowContainer = IWindowContainer(param2.findChildByName(var_1929));
            if (_loc7_ == null)
            {
                _loc7_ = IWindowContainer(this._navigator.getXmlWindow("grs_usercount"));
                _loc7_.name = var_1929;
                _loc7_.x = param5;
                _loc7_.y = param6;
                param2.addChild(_loc7_);
            };
            IInteractiveWindow(_loc7_).toolTipCaption = param4;
            var _loc8_:ITextWindow = ITextWindow(_loc7_.findChildByName("txt"));
            _loc8_.text = ("" + param3);
            var _loc9_:String = this.getBgColor(param1, param3);
            this.refreshBg(_loc7_, _loc9_);
            _loc7_.visible = true;
        }

        private function getBgColor(param1:int, param2:int):String
        {
            if (param2 == 0)
            {
                return ("b");
            };
            if (this.isOverBgColorLimit(param1, param2, "red", 92))
            {
                return ("r");
            };
            if (this.isOverBgColorLimit(param1, param2, "orange", 80))
            {
                return ("o");
            };
            if (this.isOverBgColorLimit(param1, param2, "yellow", 50))
            {
                return ("y");
            };
            return ("g");
        }

        private function isOverBgColorLimit(param1:int, param2:int, param3:String, param4:int):Boolean
        {
            var _loc5_:String = ("navigator.colorlimit." + param3);
            var _loc6_:int = int(this._navigator.configuration.getKey(_loc5_, ("" + param4)));
            var _loc7_:int = int(((param1 * _loc6_) / 100));
            return (param2 >= _loc7_);
        }

        private function refreshBg(param1:IWindowContainer, param2:String):void
        {
            var _loc4_:String;
            var _loc3_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName("usercount_bg"));
            if (_loc3_.tags[0] != param2)
            {
                Logger.log(("Redraw usercount bg: " + param2));
                _loc3_.tags.splice(0, _loc3_.tags.length);
                _loc3_.tags.push(param2);
                _loc4_ = ("usercount_fixed_" + param2);
                _loc3_.bitmap = this._navigator.getButtonImage(_loc4_);
                _loc3_.invalidate();
            };
        }

        private function refreshIcon(param1:IWindowContainer, param2:String, param3:Boolean):void
        {
            this._navigator.refreshButton(param1, param2, param3, null, 0);
        }


    }
}