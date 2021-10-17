package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import flash.geom.Point;

    public class RoomPreviewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener, IDragAndDropDoneReceiver 
    {

        private var var_3255:int = -1;
        private var var_3256:int = -1;
        private var var_3257:BitmapData = null;
        private var _imageStoreWindow:BitmapData = null;
        private var var_3258:Object;
        private var var_3078:Offer;

        public function RoomPreviewCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            if (this.var_3257 != null)
            {
                this.var_3257.dispose();
                this.var_3257 = null;
            };
            if (this._imageStoreWindow != null)
            {
                this._imageStoreWindow.dispose();
                this._imageStoreWindow = null;
            };
            events.removeEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            super.dispose();
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            var _loc1_:IBitmapWrapperWindow = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
            _loc1_.procedure = this.eventProc;
            events.addEventListener(WidgetEvent.CWE_UPDATE_ROOM_PREVIEW, this.onUpdateRoomPreview);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onPreviewProduct);
            return (true);
        }

        private function onPreviewProduct(param1:SelectProductEvent):void
        {
            if (param1 == null)
            {
                return;
            };
            this.var_3078 = param1.offer;
        }

        private function eventProc(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type == WindowMouseEvent.var_655)
            {
                this.var_3258 = null;
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_650)
                {
                    if (param2 == null)
                    {
                        return;
                    };
                    this.var_3258 = param2;
                }
                else
                {
                    if ((((param1.type == WindowMouseEvent.var_624) && (!(this.var_3258 == null))) && (this.var_3258 == param2)))
                    {
                        if (this.var_3078)
                        {
                            (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, this.var_3078);
                            this.var_3258 = null;
                        };
                    }
                    else
                    {
                        if (param1.type == WindowMouseEvent.var_655)
                        {
                            (this.var_3258 == null);
                        }
                        else
                        {
                            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                            {
                                (this.var_3258 == null);
                            }
                            else
                            {
                                if (param1.type == WindowMouseEvent.var_649)
                                {
                                    this.var_3258 = null;
                                };
                            };
                        };
                    };
                };
            };
        }

        public function onDragAndDropDone(param1:Boolean):void
        {
            if (disposed)
            {
                return;
            };
            if (param1)
            {
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false));
            };
        }

        public function stopDragAndDrop():void
        {
        }

        private function onUpdateRoomPreview(param1:CatalogWidgetUpdateRoomPreviewEvent):void
        {
            var _loc5_:BitmapData;
            var _loc6_:BitmapData;
            var _loc2_:String = "ads_twi_windw";
            var _loc3_:ImageResult = page.viewer.roomEngine.getRoomImage(param1.floorType, param1.wallType, param1.landscapeType, param1.tileSize, this, _loc2_);
            var _loc4_:ImageResult = page.viewer.roomEngine.getGenericRoomObjectImage(_loc2_, "", new Vector3d(180, 0, 0), param1.tileSize, this);
            if (((!(_loc3_ == null)) && (!(_loc4_ == null))))
            {
                this.var_3255 = _loc3_.id;
                this.var_3256 = _loc4_.id;
                _loc5_ = (_loc3_.data as BitmapData);
                _loc6_ = (_loc4_.data as BitmapData);
                if (this.var_3257 != null)
                {
                    this.var_3257.dispose();
                };
                if (this._imageStoreWindow != null)
                {
                    this._imageStoreWindow.dispose();
                };
                this.var_3257 = _loc5_;
                this._imageStoreWindow = _loc6_;
                this.setRoomImage(_loc5_, _loc6_);
            };
        }

        private function setRoomImage(param1:BitmapData, param2:BitmapData):void
        {
            var _loc3_:IBitmapWrapperWindow;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:int;
            if ((((!(param1 == null)) && (!(param2 == null))) && (!(window.disposed))))
            {
                _loc3_ = (window.getChildByName("catalog_floor_preview_example") as IBitmapWrapperWindow);
                if (_loc3_ != null)
                {
                    if (_loc3_.bitmap == null)
                    {
                        _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0xFFFFFF);
                    };
                    _loc4_ = -45;
                    _loc5_ = 20;
                    _loc3_.bitmap.fillRect(_loc3_.bitmap.rect, 0xFFFFFF);
                    _loc6_ = int((((_loc3_.width - param1.width) / 2) + _loc4_));
                    _loc7_ = int((((_loc3_.height - param1.height) / 2) + _loc5_));
                    _loc3_.bitmap.copyPixels(param1, param1.rect, new Point(_loc6_, _loc7_), null, null, true);
                    _loc8_ = int(((_loc3_.width / 2) + _loc4_));
                    _loc9_ = (((_loc3_.height / 2) + _loc5_) - param2.height);
                    _loc8_ = (_loc8_ + 1);
                    _loc9_ = (_loc9_ + 44);
                    _loc3_.bitmap.copyPixels(param2, param2.rect, new Point(_loc8_, _loc9_), null, null, true);
                    _loc3_.invalidate();
                };
            };
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            if (disposed)
            {
                return;
            };
            switch (param1)
            {
                case this.var_3255:
                    this.var_3255 = 0;
                    if (this.var_3257 != null)
                    {
                        this.var_3257.dispose();
                    };
                    this.var_3257 = param2;
                    break;
                case this.var_3256:
                    this.var_3256 = 0;
                    if (this._imageStoreWindow != null)
                    {
                        this._imageStoreWindow.dispose();
                    };
                    this._imageStoreWindow = param2;
                    break;
            };
            if (((!(this.var_3257 == null)) && (!(this._imageStoreWindow == null))))
            {
                this.setRoomImage(this.var_3257, this._imageStoreWindow);
            };
        }


    }
}