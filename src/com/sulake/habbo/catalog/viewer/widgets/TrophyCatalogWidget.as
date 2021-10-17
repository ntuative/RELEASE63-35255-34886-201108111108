package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class TrophyCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener 
    {

        private static const var_2481:int = 0xFFCC00;
        private static const var_2482:int = 0xCCCCCC;
        private static const var_2483:int = 0xCC6600;

        private var var_3228:IBitmapWrapperWindow;
        private var var_3282:Map;
        private var var_3283:int = 0;
        private var var_3284:String = "g";

        public function TrophyCatalogWidget(param1:IWindowContainer)
        {
            super(param1);
        }

        override public function dispose():void
        {
            if (this.var_3282 != null)
            {
                this.var_3282.dispose();
            };
            this.var_3282 = null;
            super.dispose();
        }

        override public function init():Boolean
        {
            var _loc4_:Map;
            var _loc5_:String;
            var _loc6_:String;
            var _loc7_:Map;
            if (!super.init())
            {
                return (false);
            };
            this.var_3228 = (window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            events.addEventListener(WidgetEvent.CWE_TEXT_INPUT, this.onTextInput);
            var _loc1_:IContainerButtonWindow = (window.findChildByName("ctlg_nextmodel_button") as IContainerButtonWindow);
            var _loc2_:IContainerButtonWindow = (window.findChildByName("ctlg_prevmodel_button") as IContainerButtonWindow);
            if (_loc1_ != null)
            {
                _loc1_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickNext);
            };
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPrev);
            };
            this.var_3282 = new Map();
            var _loc3_:Offer;
            for each (_loc3_ in page.offers)
            {
                _loc5_ = this.getBaseNameFromProduct(_loc3_.localizationId);
                _loc6_ = this.getTrophyTypeFromProduct(_loc3_.localizationId);
                if (this.var_3282.getValue(_loc5_) == null)
                {
                    this.var_3282.add(_loc5_, new Map());
                };
                _loc7_ = (this.var_3282.getValue(_loc5_) as Map);
                _loc7_.add(_loc6_, _loc3_);
            };
            _loc4_ = this.var_3282.getWithIndex(this.var_3283);
            if (_loc4_ != null)
            {
                _loc3_ = _loc4_.getValue(this.var_3284);
                if (_loc3_ == null)
                {
                    _loc3_ = _loc4_.getWithIndex(0);
                };
                if (_loc3_ != null)
                {
                    events.dispatchEvent(new SelectProductEvent(_loc3_));
                };
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            return (true);
        }

        private function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent):void
        {
            var _loc2_:Array = new Array();
            _loc2_.push(var_2481);
            _loc2_.push(var_2482);
            _loc2_.push(var_2483);
            events.dispatchEvent(new CatalogWidgetColoursEvent(_loc2_, "ctlg_clr_40x32_1", "ctlg_clr_40x32_2", "ctlg_clr_40x32_3"));
        }

        private function onSelectProduct(param1:SelectProductEvent):void
        {
            var _loc4_:BitmapData;
            var _loc5_:IProduct;
            var _loc6_:ImageResult;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:Offer = param1.offer;
            var _loc3_:IProductData = page.viewer.catalog.getProductData(_loc2_.localizationId);
            if (ProductImageConfiguration.hasProductImage(_loc2_.localizationId))
            {
                this.setPreviewFromAsset(ProductImageConfiguration.var_2480[_loc2_.localizationId]);
            }
            else
            {
                _loc5_ = _loc2_.productContainer.firstProduct;
                _loc6_ = page.viewer.roomEngine.getFurnitureImage(_loc5_.productClassId, new Vector3d(2, 0, 0), 64, this, 0, _loc5_.extraParam);
                _loc2_.previewCallbackId = _loc6_.id;
                if (_loc6_ != null)
                {
                    _loc4_ = _loc6_.data;
                };
                this.setPreviewImage(_loc4_, true);
            };
        }

        private function onColourIndex(param1:CatalogWidgetColourIndexEvent):void
        {
            var _loc3_:Offer;
            if (param1.index == 0)
            {
                this.var_3284 = "g";
            };
            if (param1.index == 1)
            {
                this.var_3284 = "s";
            };
            if (param1.index == 2)
            {
                this.var_3284 = "b";
            };
            var _loc2_:Map = this.var_3282.getWithIndex(this.var_3283);
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getValue(this.var_3284);
                if (_loc3_ == null)
                {
                    _loc3_ = _loc2_.getWithIndex(0);
                };
                if (_loc3_ != null)
                {
                    events.dispatchEvent(new SelectProductEvent(_loc3_));
                };
            };
        }

        public function onTextInput(param1:TextInputEvent):void
        {
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(param1.text));
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            var _loc3_:Offer;
            if ((((disposed) || (page == null)) || (page.offers == null)))
            {
                return;
            };
            for each (_loc3_ in page.offers)
            {
                if (_loc3_.previewCallbackId == param1)
                {
                    _loc3_.previewCallbackId = 0;
                    this.setPreviewImage(param2, true);
                    break;
                };
            };
        }

        private function getBaseNameFromProduct(param1:String):String
        {
            var _loc2_:String = this.getTrophyTypeFromProduct(param1);
            if (_loc2_.length > 0)
            {
                return (param1.slice(0, ((param1.length - 1) - _loc2_.length)));
            };
            return (param1);
        }

        private function getTrophyTypeFromProduct(param1:String):String
        {
            var _loc2_:int = param1.indexOf("prizetrophy_2011_");
            if (_loc2_ != -1)
            {
                return ("");
            };
            var _loc3_:int = (param1.lastIndexOf("_") + 1);
            if (_loc3_ <= 0)
            {
                return ("");
            };
            var _loc4_:String = param1.substr(_loc3_);
            if (((_loc4_.length > 1) || (((!(_loc4_ == "g")) && (!(_loc4_ == "s"))) && (!(_loc4_ == "b")))))
            {
                return ("");
            };
            return (_loc4_);
        }

        private function onClickNext(param1:WindowMouseEvent):void
        {
            var _loc3_:Offer;
            this.var_3283++;
            if (this.var_3283 >= this.var_3282.length)
            {
                this.var_3283 = 0;
            };
            var _loc2_:Map = this.var_3282.getWithIndex(this.var_3283);
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getValue(this.var_3284);
                if (_loc3_ == null)
                {
                    _loc3_ = _loc2_.getWithIndex(0);
                };
                if (_loc3_ != null)
                {
                    events.dispatchEvent(new SelectProductEvent(_loc3_));
                };
            };
        }

        private function onClickPrev(param1:WindowMouseEvent):void
        {
            var _loc3_:Offer;
            this.var_3283--;
            if (this.var_3283 < 0)
            {
                this.var_3283 = (this.var_3282.length - 1);
            };
            var _loc2_:Map = this.var_3282.getWithIndex(this.var_3283);
            if (_loc2_ != null)
            {
                _loc3_ = _loc2_.getValue(this.var_3284);
                if (_loc3_ == null)
                {
                    _loc3_ = _loc2_.getWithIndex(0);
                };
                if (_loc3_ != null)
                {
                    events.dispatchEvent(new SelectProductEvent(_loc3_));
                };
            };
        }

        private function setPreviewImage(param1:BitmapData, param2:Boolean):void
        {
            var _loc3_:Point;
            if (((!(window.disposed)) && (!(this.var_3228 == null))))
            {
                if (param1 == null)
                {
                    param1 = new BitmapData(1, 1);
                    param2 = true;
                };
                if (this.var_3228.bitmap == null)
                {
                    this.var_3228.bitmap = new BitmapData(this.var_3228.width, this.var_3228.height, true, 0xFFFFFF);
                };
                this.var_3228.bitmap.fillRect(this.var_3228.bitmap.rect, 0xFFFFFF);
                _loc3_ = new Point(((this.var_3228.width - param1.width) / 2), ((this.var_3228.height - param1.height) / 2));
                this.var_3228.bitmap.copyPixels(param1, param1.rect, _loc3_, null, null, true);
                this.var_3228.invalidate();
            };
            if (((param2) && (!(param1 == null))))
            {
                param1.dispose();
            };
        }

        private function setPreviewFromAsset(param1:String):void
        {
            var _loc2_:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset);
            if (_loc2_ == null)
            {
                this.retrievePreviewAsset(param1);
                return;
            };
            this.setPreviewImage((_loc2_.content as BitmapData), false);
        }

        private function retrievePreviewAsset(param1:String):void
        {
            var _loc2_:String = page.viewer.catalog.configuration.getKey("image.library.catalogue.url");
            var _loc3_:* = ((_loc2_ + param1) + ".gif");
            Logger.log(("[TrophyCatalogWidget] Retrieve Product Preview Asset: " + _loc3_));
            var _loc4_:URLRequest = new URLRequest(_loc3_);
            var _loc5_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1, _loc4_, "image/gif");
            _loc5_.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onPreviewImageReady);
        }

        private function onPreviewImageReady(param1:AssetLoaderEvent):void
        {
            var _loc2_:AssetLoaderStruct = (param1.target as AssetLoaderStruct);
            if (_loc2_ != null)
            {
                this.setPreviewFromAsset(_loc2_.assetName);
            };
        }


    }
}