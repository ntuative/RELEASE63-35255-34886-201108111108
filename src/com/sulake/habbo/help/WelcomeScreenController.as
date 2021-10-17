package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class WelcomeScreenController implements IUpdateReceiver 
    {

        private var var_4024:HabboHelp;
        private var _windowManager:IHabboWindowManager;
        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var var_4042:Point = new Point(72, 10);
        private var var_4043:WelcomeNotification;

        public function WelcomeScreenController(param1:HabboHelp, param2:IHabboWindowManager)
        {
            this.var_4024 = param1;
            this._windowManager = param2;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this.var_4024)
            {
                this.var_4024.removeUpdateReceiver(this);
                this.var_4024.toolbar.events.removeEventListener(HabboToolbarEvent.var_48, this.onToolbarClicked);
                this.var_4024 = null;
            };
            this._windowManager = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            this.var_4043 = null;
            this._disposed = true;
        }

        public function showWelcomeScreen(param1:WelcomeNotification):void
        {
            if (this._disposed)
            {
                return;
            };
            this.var_4043 = param1;
            this.var_4024.toolbar.events.addEventListener(HabboToolbarEvent.var_48, this.onToolbarClicked);
            if (this._window == null)
            {
                this.initializeWindow();
            };
            var _loc2_:ITextWindow = ITextWindow(this._window.findChildByName("text"));
            _loc2_.caption = this.var_4024.localization.getKey(param1.localizationKey);
            _loc2_.height = (_loc2_.textHeight + 5);
            this.var_4042.y = (this.var_4024.toolbar.getIconVerticalLocation(param1.targetIconId) - (this._window.height / 2));
            this._window.y = this.var_4042.y;
            var _loc3_:IWindow = this._window.findChildByName("arrow");
            _loc3_.y = ((this._window.height - _loc3_.height) / 2);
            this._window.x = -(this._window.width);
            this.registerUpdates();
            this._window.visible = true;
            this._window.activate();
        }

        private function initializeWindow():void
        {
            var _loc1_:XmlAsset = (this.var_4024.assets.getAssetByName("welcome_screen_xml") as XmlAsset);
            this._window = (this._windowManager.buildFromXML((_loc1_.content as XML), 2) as IWindowContainer);
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("arrow") as IBitmapWrapperWindow);
            var _loc3_:BitmapDataAsset = (this.var_4024.assets.getAssetByName("welcome_screen_arrow") as BitmapDataAsset);
            _loc2_.bitmap = (_loc3_.content as BitmapData).clone();
            var _loc4_:IFrameWindow = (this._window.findChildByName("frame") as IFrameWindow);
            _loc4_.header.visible = false;
            _loc4_.content.y = (_loc4_.content.y - 20);
            var _loc5_:ITextWindow = (this._window.findChildByName("text") as ITextWindow);
            _loc5_.height = (_loc5_.textHeight + 5);
            _loc4_.content.setParamFlag(WindowParam.var_690, false);
            _loc4_.height = (_loc4_.height - 20);
            this._window.findChildByName("close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
        }

        private function onMouseClick(param1:WindowMouseEvent):void
        {
            this.closeWindow();
        }

        private function onToolbarClicked(param1:HabboToolbarEvent):void
        {
            this.closeWindow();
        }

        private function closeWindow():void
        {
            if (!this._window)
            {
                return;
            };
            this._window.visible = false;
            this.dispose();
        }

        public function update(param1:uint):void
        {
            var _loc3_:Point;
            if (this._window == null)
            {
                this.var_4024.removeUpdateReceiver(this);
                return;
            };
            var _loc2_:Number = Point.distance(this._window.rectangle.topLeft, this.var_4042);
            if (_loc2_ > 5)
            {
                _loc3_ = Point.interpolate(this._window.rectangle.topLeft, this.var_4042, 0.5);
                this._window.x = _loc3_.x;
                this._window.y = _loc3_.y;
            }
            else
            {
                this._window.x = this.var_4042.x;
                this._window.y = this.var_4042.y;
                this.var_4024.removeUpdateReceiver(this);
            };
        }

        private function registerUpdates():void
        {
            this.var_4024.removeUpdateReceiver(this);
            this.var_4024.registerUpdateReceiver(this, 10);
        }


    }
}