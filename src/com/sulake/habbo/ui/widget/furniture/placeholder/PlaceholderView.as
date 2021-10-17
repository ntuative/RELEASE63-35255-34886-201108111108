package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PlaceholderView 
    {

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;

        public function PlaceholderView(param1:IAssetLibrary, param2:IHabboWindowManager)
        {
            this._assetLibrary = param1;
            this._windowManager = param2;
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function toggleWindow():void
        {
            if (((!(this._window == null)) && (this._window.visible)))
            {
                this.hideWindow();
            }
            else
            {
                this.showWindow();
            };
        }

        public function showWindow():void
        {
            if (this._window == null)
            {
                this.createWindow();
            };
            if (this._window == null)
            {
                return;
            };
            this._window.visible = true;
            this._window.x = 200;
        }

        private function createWindow():void
        {
            var _loc1_:XmlAsset = (this._assetLibrary.getAssetByName("placeholder") as XmlAsset);
            if (((_loc1_ == null) || (_loc1_.content == null)))
            {
                return;
            };
            this._window = (this._windowManager.createWindow("habbohelp_window", "", HabboWindowType.var_218, HabboWindowStyle.var_157, (HabboWindowParam.var_829 | HabboWindowParam.var_158), new Rectangle(-300, 300, 10, 10), null) as IWindowContainer);
            this._window.buildFromXML((_loc1_.content as XML));
            this._window.tags.push("habbo_help_window");
            this._window.background = true;
            this._window.color = 0x1FFFFFF;
            var _loc2_:IWindow = this._window.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.procedure = this.onWindowClose;
            };
        }

        public function hideWindow():void
        {
            if (this._window != null)
            {
                this._window.visible = false;
            };
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.hideWindow();
        }


    }
}