package com.sulake.habbo.ui.widget.infostand
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.tracking.IHabboTracking;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.events.WindowEvent;

    public class InfoStandFurniView 
    {

        protected var _window:IItemListWindow;
        protected var var_2392:IBorderWindow;
        protected var _buttons:IItemListWindow;
        protected var _catalog:IHabboCatalog;
        protected var _habboTracking:IHabboTracking;
        protected var var_2393:IWindow;
        protected var _widget:InfostandWidget;
        protected var var_2394:IItemListWindow;

        public function InfoStandFurniView(param1:InfostandWidget, param2:String, param3:IHabboCatalog)
        {
            this._widget = param1;
            this._catalog = param3;
            this._habboTracking = HabboTracking.getInstance();
            this.createWindow(param2);
        }

        public function dispose():void
        {
            this._catalog = null;
            this._widget = null;
            this._window.dispose();
            this._window = null;
        }

        public function get window():IItemListWindow
        {
            return (this._window);
        }

        protected function createWindow(param1:String):void
        {
            var _loc4_:IWindow;
            var _loc5_:int;
            var _loc2_:XmlAsset = (this._widget.assets.getAssetByName("furni_view") as XmlAsset);
            this._window = (this._widget.windowManager.buildFromXML((_loc2_.content as XML)) as IItemListWindow);
            if (this._window == null)
            {
                throw (new Error("Failed to construct window from XML!"));
            };
            this.var_2392 = (this._window.getListItemByName("info_border") as IBorderWindow);
            this._buttons = (this._window.getListItemByName("button_list") as IItemListWindow);
            if (this.var_2392 != null)
            {
                this.var_2394 = (this.var_2392.findChildByName("infostand_element_list") as IItemListWindow);
            };
            this._window.name = param1;
            this._widget.mainContainer.addChild(this._window);
            var _loc3_:IWindow = this.var_2392.findChildByTag("close");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            if (this._buttons != null)
            {
                _loc5_ = 0;
                while (_loc5_ < this._buttons.numListItems)
                {
                    _loc4_ = this._buttons.getListItemAt(_loc5_);
                    _loc4_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                    _loc5_++;
                };
            };
            this.var_2393 = this.var_2392.findChildByTag("catalog");
            if (this.var_2393 != null)
            {
                this.var_2393.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCatalogButtonClicked);
            };
        }

        protected function onClose(param1:WindowMouseEvent):void
        {
            this._widget.close();
        }

        public function set name(param1:String):void
        {
            var _loc2_:ITextWindow = (this.var_2394.getListItemByName("name_text") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = param1;
            _loc2_.visible = true;
            _loc2_.height = (_loc2_.textHeight + 5);
            this.updateWindow();
        }

        public function set image(param1:BitmapData):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this.var_2394.getListItemByName("image") as IBitmapWrapperWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:BitmapData = new BitmapData(_loc2_.width, param1.height, true, 0);
            var _loc4_:Point = new Point(((_loc2_.width - param1.width) / 2), 0);
            _loc3_.copyPixels(param1, param1.rect, _loc4_);
            _loc2_.height = param1.height;
            _loc2_.bitmap = _loc3_;
            _loc2_.invalidate();
            this.updateWindow();
        }

        public function set description(param1:String):void
        {
            var _loc2_:ITextWindow = (this.var_2394.getListItemByName("description_text") as ITextWindow);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.text = param1;
            _loc2_.height = (_loc2_.textHeight + 5);
            this.updateWindow();
        }

        private function set expiration(param1:int):void
        {
            var _loc2_:ITextWindow = (this.var_2394.getListItemByName("expiration_text") as ITextWindow);
            var _loc3_:IWindowContainer = (this.var_2394.getListItemByName("expiration_spacer") as IWindowContainer);
            if (((_loc2_ == null) || (_loc3_ == null)))
            {
                return;
            };
            this._widget.localizations.registerParameter("infostand.rent.expiration", "minutes", param1.toString());
            if (param1 <= 0)
            {
                _loc2_.height = 0;
                _loc3_.height = 0;
            }
            else
            {
                _loc2_.height = (_loc2_.textHeight + 5);
                _loc3_.height = 1;
            };
            this.updateWindow();
        }

        protected function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:RoomWidgetMessage;
            var _loc3_:String;
            var _loc4_:String;
            var _loc6_:int;
            var _loc7_:int;
            var _loc5_:IWindow = (param1.target as IWindow);
            switch (_loc5_.name)
            {
                case "rotate":
                    _loc3_ = RoomWidgetFurniActionMessage.var_2297;
                    break;
                case "move":
                    _loc3_ = RoomWidgetFurniActionMessage.var_1174;
                    break;
                case "pickup":
                    _loc3_ = RoomWidgetFurniActionMessage.var_2298;
                    this._widget.close();
                    break;
                case "save_branding_configuration":
                    _loc3_ = RoomWidgetFurniActionMessage.var_2300;
                    _loc4_ = this.getVisibleAdFurnitureExtraParams();
                    break;
                case "use":
                    _loc3_ = RoomWidgetFurniActionMessage.var_2299;
                    break;
            };
            if (_loc3_ != null)
            {
                _loc6_ = this._widget.furniData.id;
                _loc7_ = this._widget.furniData.category;
                _loc2_ = new RoomWidgetFurniActionMessage(_loc3_, _loc6_, _loc7_, _loc4_);
                this._widget.messageListener.processWidgetMessage(_loc2_);
            };
        }

        protected function onCatalogButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc2_:int;
            var _loc3_:int;
            if (this._catalog)
            {
                _loc2_ = this._widget.furniData.catalogPageId;
                _loc3_ = this._widget.furniData.offerId;
                if (_loc2_ > -1)
                {
                    this._catalog.openCatalogPageById(_loc2_, _loc3_);
                    if (((this._habboTracking) && (!(this._habboTracking.disposed))))
                    {
                        this._habboTracking.trackGoogle("infostandCatalogButton", "offer", _loc3_);
                    };
                };
            };
        }

        protected function updateWindow():void
        {
            if ((((this.var_2394 == null) || (this.var_2392 == null)) || (this._buttons == null)))
            {
                return;
            };
            this._buttons.width = this._buttons.scrollableRegion.width;
            this.var_2394.height = this.var_2394.scrollableRegion.height;
            this.var_2392.height = (this.var_2394.height + 20);
            this._window.width = Math.max(this.var_2392.width, this._buttons.width);
            this._window.height = this._window.scrollableRegion.height;
            if (this.var_2392.width < this._buttons.width)
            {
                this.var_2392.x = (this._window.width - this.var_2392.width);
                this._buttons.x = 0;
            }
            else
            {
                this._buttons.x = (this._window.width - this._buttons.width);
                this.var_2392.x = 0;
            };
            this._widget.refreshContainer();
        }

        public function update(param1:RoomWidgetFurniInfoUpdateEvent):void
        {
            this.name = param1.name;
            this.description = param1.description;
            this.image = param1.image;
            this.expiration = param1.expiration;
            var _loc2_:Boolean;
            var _loc3_:Boolean;
            var _loc4_:Boolean;
            var _loc5_:Boolean;
            var _loc6_:Boolean;
            if (param1.isRoomController)
            {
                _loc2_ = true;
                _loc3_ = true;
            };
            if (((param1.isRoomOwner) || (param1.isAnyRoomController)))
            {
                _loc2_ = true;
                _loc3_ = true;
                _loc4_ = true;
            };
            if (_loc3_)
            {
                _loc3_ = (!(param1.isWallItem));
            };
            if (param1.isStickie)
            {
                _loc4_ = false;
            };
            if (param1.isAnyRoomController)
            {
                _loc5_ = true;
            };
            if (((param1.extraParam == RoomWidgetInfostandExtraParamEnum.var_1942) || ((param1.extraParam == RoomWidgetInfostandExtraParamEnum.var_1083) && (param1.isRoomOwner))))
            {
                _loc6_ = this._widget.config.getBoolean("infostand.use.button.enabled", false);
            };
            this.showButton("move", _loc2_);
            this.showButton("rotate", _loc3_);
            this.showButton("pickup", _loc4_);
            this.showButton("use", _loc6_);
            this.showAdFurnitureDetails(_loc5_);
            if (param1.catalogPageId < 0)
            {
                this.showCatalogButton(false);
            }
            else
            {
                this.showCatalogButton(true);
            };
            this._buttons.visible = ((((_loc2_) || (_loc3_)) || (_loc4_)) || (_loc6_));
            this.updateWindow();
        }

        private function createAdElement(param1:String, param2:String):void
        {
            var _loc3_:XmlAsset;
            var _loc4_:IWindowContainer;
            var _loc5_:IWindow;
            var _loc6_:IWindow;
            if (this.var_2394 != null)
            {
                _loc3_ = (this._widget.assets.getAssetByName("furni_view_branding_element") as XmlAsset);
                if (_loc3_ != null)
                {
                    _loc4_ = (this._widget.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
                    if (_loc4_ != null)
                    {
                        _loc5_ = _loc4_.findChildByName("element_name");
                        if (_loc5_ != null)
                        {
                            _loc5_.caption = param1;
                        };
                        _loc6_ = _loc4_.findChildByName("element_value");
                        if (_loc6_ != null)
                        {
                            _loc6_.caption = param2;
                            _loc6_.addEventListener(WindowKeyboardEvent.var_1253, this.adElementKeyEventProc);
                        };
                        if (((!(_loc5_ == null)) && (!(_loc6_ == null))))
                        {
                            this.var_2394.addListItem(_loc4_);
                        };
                    };
                };
            };
        }

        private function getAdFurnitureExtraParams():Map
        {
            var _loc2_:String;
            var _loc3_:Array;
            var _loc4_:String;
            var _loc5_:Array;
            var _loc6_:String;
            var _loc7_:String;
            var _loc1_:Map = new Map();
            if (this._widget != null)
            {
                _loc2_ = this._widget.furniData.extraParam.substr(RoomWidgetInfostandExtraParamEnum.var_1063.length);
                _loc3_ = _loc2_.split("\t");
                if (_loc3_ != null)
                {
                    for each (_loc4_ in _loc3_)
                    {
                        _loc5_ = _loc4_.split("=", 2);
                        if (((!(_loc5_ == null)) && (_loc5_.length == 2)))
                        {
                            _loc6_ = _loc5_[0];
                            _loc7_ = _loc5_[1];
                            _loc1_.add(_loc6_, _loc7_);
                        };
                    };
                };
            };
            return (_loc1_);
        }

        private function getVisibleAdFurnitureExtraParams():String
        {
            var _loc2_:Array;
            var _loc3_:IWindowContainer;
            var _loc4_:IWindow;
            var _loc5_:IWindow;
            var _loc6_:String;
            var _loc7_:String;
            var _loc1_:String = "";
            if (this.var_2392 != null)
            {
                _loc2_ = [];
                this.var_2392.groupChildrenWithTag("branding_element", _loc2_, true);
                if (_loc2_.length > 0)
                {
                    for each (_loc3_ in _loc2_)
                    {
                        _loc4_ = _loc3_.findChildByName("element_name");
                        _loc5_ = _loc3_.findChildByName("element_value");
                        if (((!(_loc4_ == null)) && (!(_loc5_ == null))))
                        {
                            _loc6_ = this.trimAdFurnitureExtramParam(_loc4_.caption);
                            _loc7_ = this.trimAdFurnitureExtramParam(_loc5_.caption);
                            _loc1_ = (_loc1_ + (((_loc6_ + "=") + _loc7_) + "\t"));
                        };
                    };
                };
            };
            return (_loc1_);
        }

        private function trimAdFurnitureExtramParam(param1:String):String
        {
            if (param1 != null)
            {
                if (param1.indexOf("\t") != -1)
                {
                    return (param1.replace("\t", ""));
                };
            };
            return (param1);
        }

        private function showAdFurnitureDetails(param1:Boolean):void
        {
            var _loc6_:IWindow;
            var _loc7_:String;
            var _loc8_:Map;
            var _loc9_:String;
            var _loc10_:String;
            if (((this._widget == null) || (this.var_2392 == null)))
            {
                return;
            };
            var _loc2_:IWindow = this.var_2392.findChildByName("furni_details_spacer");
            if (_loc2_ != null)
            {
                _loc2_.visible = param1;
            };
            var _loc3_:Array = [];
            this.var_2392.groupChildrenWithTag("branding_element", _loc3_, true);
            if (_loc3_.length > 0)
            {
                for each (_loc6_ in _loc3_)
                {
                    this.var_2392.removeChild(_loc6_);
                    _loc6_.dispose();
                };
            };
            var _loc4_:Boolean;
            var _loc5_:IWindow = (this.var_2392.findChildByName("furni_details_text") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc5_.visible = param1;
                _loc7_ = ("id: " + this._widget.furniData.id);
                _loc8_ = this.getAdFurnitureExtraParams();
                if (_loc8_.length > 0)
                {
                    _loc4_ = true;
                    for each (_loc9_ in _loc8_.getKeys())
                    {
                        _loc10_ = _loc8_.getValue(_loc9_);
                        this.createAdElement(_loc9_, _loc10_);
                    };
                };
                _loc5_.caption = _loc7_;
            };
            this.showButton("save_branding_configuration", _loc4_);
        }

        private function adElementKeyEventProc(param1:WindowEvent=null, param2:IWindow=null):void
        {
        }

        private function showButton(param1:String, param2:Boolean):void
        {
            if (this._buttons == null)
            {
                return;
            };
            var _loc3_:IWindow = this._buttons.getListItemByName(param1);
            if (_loc3_ != null)
            {
                _loc3_.visible = param2;
                this._buttons.arrangeListItems();
            };
        }

        private function showCatalogButton(param1:Boolean):void
        {
            if (param1)
            {
                if (!this.var_2394.getListItemByName("catalog_button"))
                {
                    this.var_2394.addListItem(this.var_2393);
                };
                this.var_2393.visible = param1;
            }
            else
            {
                this.var_2394.removeListItem(this.var_2393);
            };
        }


    }
}