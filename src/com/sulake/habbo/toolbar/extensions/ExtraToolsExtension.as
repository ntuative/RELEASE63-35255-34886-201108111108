package com.sulake.habbo.toolbar.extensions
{
    import com.sulake.habbo.toolbar.HabboToolbar;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowEvent;

    public class ExtraToolsExtension 
    {

        private static const var_1715:uint = 0xFFFFFF;
        private static const var_1714:uint = 12247545;
        private static const var_1716:String = "HELP";
        private static const MENU_ROOMINFO:String = "ROOMINFO";

        private var var_3317:HabboToolbar;
        private var _windowManager:IHabboWindowManager;
        private var _assets:IAssetLibrary;
        private var _events:IEventDispatcher;
        private var _config:IHabboConfigurationManager;
        private var _window:IWindowContainer;
        private var var_2632:IItemListWindow;
        private var var_4258:IWindow;
        private var var_5108:IWindowContainer;

        public function ExtraToolsExtension(param1:HabboToolbar, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IEventDispatcher, param5:IHabboConfigurationManager)
        {
            var _loc8_:IWindow;
            super();
            this.var_3317 = param1;
            this._windowManager = param2;
            this._assets = param3;
            this._events = param4;
            this._config = param5;
            this._window = (this.createWindow("logout_xml") as IWindowContainer);
            var _loc6_:IBitmapWrapperWindow = (this._window.findChildByName("roominfo_icon") as IBitmapWrapperWindow);
            _loc6_.bitmap = (BitmapDataAsset(param3.getAssetByName("roominfo_icon")).content as BitmapData);
            _loc6_.disposesBitmap = false;
            this.insertLocalizations();
            this.var_4258 = this._window.findChildByName("roominfo_region");
            this.var_2632 = (this._window.findChildByName("list") as IItemListWindow);
            var _loc7_:Array = [];
            this.var_2632.groupListItemsWithTag("REGION", _loc7_);
            for each (_loc8_ in _loc7_)
            {
                _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
                _loc8_.addEventListener(WindowMouseEvent.var_624, this.onMouseOut);
            };
            this.hideRoomInfo();
        }

        public function get window():IWindow
        {
            return (this._window);
        }

        private function insertLocalizations():void
        {
            var _loc1_:IWindow;
            _loc1_ = this._window.findChildByName("roominfo_text");
            _loc1_.caption = ((("$" + "{") + _loc1_.caption) + "}");
            _loc1_ = this._window.findChildByName("help_text");
            _loc1_.caption = ((("$" + "{") + _loc1_.caption) + "}");
            _loc1_ = this._window.findChildByName("logout_text");
            _loc1_.caption = ((("$" + "{") + _loc1_.caption) + "}");
        }

        public function dispose():void
        {
            this.var_3317 = null;
            this._windowManager = null;
            this._assets = null;
            this._events = null;
            this._config = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5108)
            {
                this.var_5108.dispose();
                this.var_5108 = null;
            };
        }

        public function hideRoomInfo():void
        {
            this.var_2632.removeListItem(this.var_4258);
        }

        public function showRoomInfo():void
        {
            this.var_2632.addListItemAt(this.var_4258, 0);
        }

        private function onMouseOver(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow = (IWindowContainer(param1.window).findChildByTag("TEXT") as ITextWindow);
            _loc2_.textColor = var_1714;
        }

        private function onMouseOut(param1:WindowMouseEvent):void
        {
            var _loc2_:ITextWindow = (IWindowContainer(param1.window).findChildByTag("TEXT") as ITextWindow);
            _loc2_.textColor = var_1715;
        }

        private function createWindow(param1:String):IWindow
        {
            var _loc2_:XmlAsset = (this._assets.getAssetByName(param1) as XmlAsset);
            var _loc3_:IWindow = this._windowManager.buildFromXML((_loc2_.content as XML));
            _loc3_.procedure = this.onClick;
            return (_loc3_);
        }

        private function showConfirmation():void
        {
            var _loc1_:Point;
            if (!this.var_5108)
            {
                this.var_5108 = (this.createWindow("logout_confirmation_xml") as IWindowContainer);
                _loc1_ = new Point();
                this._window.getGlobalPosition(_loc1_);
                this.var_5108.x = ((_loc1_.x + this._window.width) - this.var_5108.width);
                this.var_5108.y = ((_loc1_.y + this._window.height) - this.var_5108.height);
            };
        }

        private function closeConfirmation():void
        {
            if (this.var_5108)
            {
                this.var_5108.dispose();
                this.var_5108 = null;
            };
        }

        private function onClick(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "logout_region":
                    this.showConfirmation();
                    return;
                case "help_region":
                    this.var_3317.toggleWindowVisibility(var_1716);
                    return;
                case "roominfo_region":
                    this.var_3317.toggleWindowVisibility(MENU_ROOMINFO);
                    return;
                case "confirm":
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("FlashExternalInterface.logout");
                    };
                    this.closeConfirmation();
                    return;
                case "cancel":
                    this.closeConfirmation();
                    return;
            };
        }


    }
}