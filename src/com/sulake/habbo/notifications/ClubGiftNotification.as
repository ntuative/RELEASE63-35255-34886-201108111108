package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubGiftNotification 
    {

        private static const var_621:String = "club_gift_notification";
        private static const var_627:uint = 0xFFFFFF;
        private static const var_626:uint = 12247545;
        private static const var_623:int = 13;
        private static const var_622:int = 14;

        private var _window:IBorderWindow;
        private var _catalog:IHabboCatalog;
        private var var_3317:IHabboToolbar;
        private var var_4377:ITextWindow;

        public function ClubGiftNotification(param1:int, param2:IAssetLibrary, param3:IHabboWindowManager, param4:IHabboCatalog, param5:IHabboToolbar)
        {
            if ((((!(param2)) || (!(param3))) || (!(param4))))
            {
                return;
            };
            this._catalog = param4;
            this.var_3317 = param5;
            var _loc6_:XmlAsset = (param2.getAssetByName("club_gift_notification_xml") as XmlAsset);
            if (_loc6_ == null)
            {
                return;
            };
            this._window = (param3.buildFromXML((_loc6_.content as XML)) as IBorderWindow);
            if (this._window == null)
            {
                return;
            };
            this._window.procedure = this.eventHandler;
            this.var_3317.extensionView.attachExtension(var_621, this._window);
            this.var_4377 = (this._window.findChildByName("cancel_link") as ITextWindow);
            var _loc7_:IRegionWindow = (this._window.findChildByName("cancel_link_region") as IRegionWindow);
            if (_loc7_)
            {
                _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOver);
                _loc7_.addEventListener(WindowMouseEvent.var_624, this.onMouseOut);
            };
            if (this._catalog.getPurse().isVIP)
            {
                this.setClubIcon(var_622);
            }
            else
            {
                this.setClubIcon(var_623);
            };
        }

        public function get visible():Boolean
        {
            return ((this._window) && (this._window.visible));
        }

        public function dispose():void
        {
            if (this.var_3317)
            {
                this.var_3317.extensionView.detachExtension(var_621);
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this._catalog = null;
        }

        private function setImage(param1:String, param2:BitmapData):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName(param1) as IBitmapWrapperWindow);
            if (_loc3_ == null)
            {
                return;
            };
            var _loc4_:BitmapData = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
            var _loc5_:int = ((_loc4_.width * 0.5) - param2.width);
            var _loc6_:int = ((_loc4_.height * 0.5) - param2.height);
            _loc4_.draw(param2, new Matrix(2, 0, 0, 2, _loc5_, _loc6_));
            _loc3_.bitmap = _loc4_;
        }

        private function eventHandler(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "open_catalog_button":
                    if (this._catalog)
                    {
                        this._catalog.openCatalogPage(CatalogPageName.var_625, true);
                    };
                    this.dispose();
                    return;
                case "cancel_link_region":
                case "cancel_link":
                    this.dispose();
                    return;
            };
        }

        private function onMouseOver(param1:WindowMouseEvent):void
        {
            this.var_4377.textColor = var_626;
        }

        private function onMouseOut(param1:WindowMouseEvent):void
        {
            this.var_4377.textColor = var_627;
        }

        private function setClubIcon(param1:int):void
        {
            var _loc2_:IIconWindow;
            if (this._window)
            {
                _loc2_ = (this._window.findChildByName("club_icon") as IIconWindow);
                if (_loc2_)
                {
                    _loc2_.style = param1;
                    _loc2_.invalidate();
                };
            };
        }


    }
}