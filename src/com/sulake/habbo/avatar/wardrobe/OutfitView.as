package com.sulake.habbo.avatar.wardrobe
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OutfitView 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _window:IWindowContainer;
        private var var_2897:IBitmapWrapperWindow;

        public function OutfitView(param1:IHabboWindowManager, param2:IAssetLibrary, param3:Boolean)
        {
            this._windowManager = param1;
            this._assetLibrary = param2;
            var _loc4_:XmlAsset = (this._assetLibrary.getAssetByName("Outfit") as XmlAsset);
            this._window = IWindowContainer(this._windowManager.buildFromXML((_loc4_.content as XML)));
            if (this._window != null)
            {
                this.var_2897 = (this._window.findChildByName("bitmap") as IBitmapWrapperWindow);
            };
            if (!param3)
            {
                this._window.findChildByName("button").disable();
            };
        }

        public function dispose():void
        {
            this._windowManager = null;
            this._assetLibrary = null;
            if (this._window)
            {
                this._window.dispose();
            };
            this._window = null;
            if (this.var_2897)
            {
                this.var_2897.dispose();
            };
            this.var_2897 = null;
        }

        public function udpate(param1:BitmapData):void
        {
            this.var_2897.bitmap = new BitmapData(this.var_2897.width, this.var_2897.height, true, 0xFFFFFF);
            var _loc2_:int = int(((this.var_2897.width - param1.width) / 2));
            var _loc3_:int = (this.var_2897.height - param1.height);
            this.var_2897.bitmap.copyPixels(param1, param1.rect, new Point(_loc2_, _loc3_));
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        private function windowEventProc(param1:WindowEvent, param2:IWindow=null):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                Logger.log("[OutfitView] Click! This should be over-ridden!");
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    this._window.color = 0xCCCCCC;
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        this._window.color = 0x666666;
                    };
                };
            };
        }


    }
}