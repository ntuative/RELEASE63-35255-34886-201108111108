package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.ui.Keyboard;

    public class TextFieldManager 
    {

        private var _navigator:HabboNavigator;
        private var var_4369:ITextFieldWindow;
        private var var_4192:Boolean;
        private var var_3969:String = "";
        private var var_4370:int;
        private var var_4371:Function;
        private var var_4372:String = "";
        private var var_4373:IWindowContainer;
        private var _orgTextBackground:Boolean;
        private var var_4374:uint;
        private var _orgTextColor:uint;

        public function TextFieldManager(param1:HabboNavigator, param2:ITextFieldWindow, param3:int=1000, param4:Function=null, param5:String=null)
        {
            this._navigator = param1;
            this.var_4369 = param2;
            this.var_4370 = param3;
            this.var_4371 = param4;
            if (param5 != null)
            {
                this.var_4192 = true;
                this.var_3969 = param5;
                this.var_4369.text = param5;
            };
            Util.setProcDirectly(this.var_4369, this.onInputClick);
            this.var_4369.addEventListener(WindowKeyboardEvent.var_1253, this.checkEnterPress);
            this.var_4369.addEventListener(WindowEvent.var_606, this.checkMaxLen);
            this._orgTextBackground = this.var_4369.textBackground;
            this.var_4374 = this.var_4369.textBackgroundColor;
            this._orgTextColor = this.var_4369.textColor;
        }

        public function dispose():void
        {
            if (this.var_4369)
            {
                this.var_4369.dispose();
                this.var_4369 = null;
            };
            if (this.var_4373)
            {
                this.var_4373.dispose();
                this.var_4373 = null;
            };
            this._navigator = null;
        }

        public function checkMandatory(param1:String):Boolean
        {
            if (!this.isInputValid())
            {
                this.displayError(param1);
                return (false);
            };
            this.restoreBackground();
            return (true);
        }

        public function restoreBackground():void
        {
            this.var_4369.textBackground = this._orgTextBackground;
            this.var_4369.textBackgroundColor = this.var_4374;
            this.var_4369.textColor = this._orgTextColor;
        }

        public function displayError(param1:String):void
        {
            this.var_4369.textBackground = true;
            this.var_4369.textBackgroundColor = 4294021019;
            this.var_4369.textColor = 0xFF000000;
            if (this.var_4373 == null)
            {
                this.var_4373 = IWindowContainer(this._navigator.getXmlWindow("nav_error_popup"));
                this._navigator.refreshButton(this.var_4373, "popup_arrow_down", true, null, 0);
                IWindowContainer(this.var_4369.parent).addChild(this.var_4373);
            };
            var _loc2_:ITextWindow = ITextWindow(this.var_4373.findChildByName("error_text"));
            _loc2_.text = param1;
            _loc2_.width = (_loc2_.textWidth + 5);
            this.var_4373.findChildByName("border").width = (_loc2_.width + 15);
            this.var_4373.width = (_loc2_.width + 15);
            var _loc3_:Point = new Point();
            this.var_4369.getLocalPosition(_loc3_);
            this.var_4373.x = _loc3_.x;
            this.var_4373.y = ((_loc3_.y - this.var_4373.height) + 3);
            var _loc4_:IWindow = this.var_4373.findChildByName("popup_arrow_down");
            _loc4_.x = ((this.var_4373.width / 2) - (_loc4_.width / 2));
            this.var_4373.x = (this.var_4373.x + ((this.var_4369.width - this.var_4373.width) / 2));
            this.var_4373.visible = true;
        }

        public function goBackToInitialState():void
        {
            this.clearErrors();
            if (this.var_3969 != null)
            {
                this.var_4369.text = this.var_3969;
                this.var_4192 = true;
            }
            else
            {
                this.var_4369.text = "";
                this.var_4192 = false;
            };
        }

        public function getText():String
        {
            if (this.var_4192)
            {
                return (this.var_4372);
            };
            return (this.var_4369.text);
        }

        public function setText(param1:String):void
        {
            this.var_4192 = false;
            this.var_4369.text = param1;
        }

        public function clearErrors():void
        {
            this.restoreBackground();
            if (this.var_4373 != null)
            {
                this.var_4373.visible = false;
            };
        }

        public function get input():ITextFieldWindow
        {
            return (this.var_4369);
        }

        private function isInputValid():Boolean
        {
            return ((!(this.var_4192)) && (Util.trim(this.getText()).length > 2));
        }

        private function onInputClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowEvent.var_568)
            {
                return;
            };
            if (!this.var_4192)
            {
                return;
            };
            this.var_4369.text = this.var_4372;
            this.var_4192 = false;
            this.restoreBackground();
        }

        private function checkEnterPress(param1:WindowKeyboardEvent):void
        {
            if (param1.charCode == Keyboard.ENTER)
            {
                if (this.var_4371 != null)
                {
                    this.var_4371();
                };
            };
        }

        private function checkMaxLen(param1:WindowEvent):void
        {
            var _loc2_:String = this.var_4369.text;
            if (_loc2_.length > this.var_4370)
            {
                this.var_4369.text = _loc2_.substring(0, this.var_4370);
            };
        }


    }
}