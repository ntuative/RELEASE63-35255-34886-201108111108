package com.sulake.habbo.friendbar.view.tabs.tokens
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.friendbar.data.FriendNotification;
    import com.sulake.habbo.friendbar.view.utils.DropAnimation;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.enum.WindowStyle;
    import com.sulake.core.window.enum.WindowParam;

    public class Token implements IDisposable 
    {

        protected static var var_2126:IHabboWindowManager;
        protected static var var_2127:IAssetLibrary;
        protected static const ICON:String = "icon";
        protected static const var_2128:String = "title";
        protected static const var_2094:String = "message";
        protected static const var_3921:Rectangle = new Rectangle(0, 0, 25, 25);

        protected var _icon:IRegionWindow;
        protected var _window:IWindowContainer;
        protected var _disposed:Boolean;
        protected var var_3922:FriendNotification;
        protected var var_2886:DropAnimation;

        public function Token(param1:FriendNotification)
        {
            this.var_3922 = param1;
        }

        public static function set WINDOWING(param1:IHabboWindowManager):void
        {
            var_2126 = param1;
        }

        public static function set ASSETS(param1:IAssetLibrary):void
        {
            var_2127 = param1;
        }


        public function get typeCode():int
        {
            return (this.var_3922.typeCode);
        }

        public function get viewOnce():Boolean
        {
            return (this.var_3922.viewOnce);
        }

        public function get notification():FriendNotification
        {
            return (this.var_3922);
        }

        public function get iconElement():IWindow
        {
            return (this._icon);
        }

        public function get windowElement():IWindow
        {
            return (this._window);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this._icon)
            {
                this._icon.dispose();
                this._icon = null;
            };
            if (this.var_2886)
            {
                this.var_2886.dispose();
                this.var_2886 = null;
            };
            this.var_3922 = null;
            this._disposed = true;
        }

        protected function prepare(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean):void
        {
            var _loc7_:BitmapDataAsset;
            this._window = (var_2126.buildFromXML((var_2127.getAssetByName(param3).content as XML)) as IWindowContainer);
            this._window.findChildByName(var_2128).caption = param1;
            this._window.findChildByName(var_2094).caption = ((param2) ? param2 : "");
            _loc7_ = (var_2127.getAssetByName(param5) as BitmapDataAsset);
            if (_loc7_)
            {
                IBitmapWrapperWindow(this._window.findChildByName(ICON)).bitmap = (_loc7_.content as BitmapData);
            };
            this._icon = (var_2126.create(("ICON_" + this.typeCode), WindowType.var_1120, WindowStyle.var_1192, WindowParam.var_609, Token.var_3921) as IRegionWindow);
            this._icon.mouseThreshold = 0;
            var _loc8_:IBitmapWrapperWindow = (var_2126.create(("BITMAP_" + this.typeCode), WindowType.var_928, WindowStyle.var_1192, WindowParam.var_714, Token.var_3921) as IBitmapWrapperWindow);
            _loc8_.disposesBitmap = false;
            _loc7_ = (var_2127.getAssetByName(param4) as BitmapDataAsset);
            if (_loc7_)
            {
                _loc8_.bitmap = (_loc7_.content as BitmapData);
            };
            this._icon.addChild(_loc8_);
            if (this.var_2886)
            {
                this.var_2886.dispose();
            };
            if (param6)
            {
                this.var_2886 = new DropAnimation(this._icon, 600, 32);
            };
        }


    }
}