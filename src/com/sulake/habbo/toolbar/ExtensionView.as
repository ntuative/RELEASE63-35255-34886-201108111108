package com.sulake.habbo.toolbar
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.Core;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.toolbar.events.ExtensionViewEvent;

    public class ExtensionView implements IExtensionView 
    {

        private static const var_1739:int = 3;

        private var var_3317:HabboToolbar;
        private var var_5113:IItemListWindow;
        private var _items:Map;
        private var _disposed:Boolean = false;

        public function ExtensionView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:HabboToolbar)
        {
            this.var_3317 = param3;
            var _loc4_:XmlAsset = (param2.getAssetByName("extension_grid_xml") as XmlAsset);
            if (_loc4_)
            {
                this.var_5113 = (param1.buildFromXML((_loc4_.content as XML), 1) as IItemListWindow);
            };
            var _loc5_:IWindowContainer = this.var_5113.desktop;
            if (this.var_5113)
            {
                this.var_5113.x = ((_loc5_.width - this.var_5113.width) - var_1739);
                this.var_5113.y = var_1739;
                this.var_5113.visible = true;
            }
            else
            {
                Core.error("Unable to initialize Toolbar Extension view window from xml asset", false, Core.var_87);
            };
            this._items = new Map();
        }

        public function dispose():void
        {
            var _loc1_:Array;
            var _loc2_:String;
            if (!this._disposed)
            {
                _loc1_ = this._items.getKeys();
                for each (_loc2_ in _loc1_)
                {
                    this.detachExtension(_loc2_);
                };
                if (this.var_5113)
                {
                    this.var_5113.dispose();
                    this.var_5113 = null;
                };
                this.var_3317 = null;
                this._items = null;
                this._disposed = true;
            };
        }

        public function get screenHeight():uint
        {
            if (!this.var_5113)
            {
                return (0);
            };
            return (this.var_5113.height + this.var_5113.y);
        }

        public function attachExtension(param1:String, param2:IWindow, param3:int=-1):void
        {
            if (this._items.getValue(param1))
            {
                return;
            };
            this._items.add(param1, param2);
            if (this.var_5113)
            {
                if (param3 == -1)
                {
                    this.var_5113.addListItem(param2);
                }
                else
                {
                    this.var_5113.addListItemAt(param2, param3);
                };
                this.var_5113.invalidate();
            };
            this.queueResizeEvent();
        }

        public function detachExtension(param1:String):void
        {
            var _loc2_:IWindow = this._items[param1];
            if (this.var_5113)
            {
                this.var_5113.removeListItem(_loc2_);
            };
            this._items.remove(param1);
            this.queueResizeEvent();
        }

        private function queueResizeEvent():void
        {
            var _loc1_:Timer = new Timer(25, 1);
            _loc1_.addEventListener(TimerEvent.TIMER_COMPLETE, this.onResizeTimer);
            _loc1_.start();
        }

        private function onResizeTimer(param1:TimerEvent):void
        {
            if (this.var_3317)
            {
                this.var_3317.events.dispatchEvent(new ExtensionViewEvent(ExtensionViewEvent.var_558));
            };
        }


    }
}