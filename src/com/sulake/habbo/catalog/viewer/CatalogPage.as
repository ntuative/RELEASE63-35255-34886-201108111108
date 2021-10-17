package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.CatalogWidgetEnum;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGroupCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
    import flash.events.Event;

    public class CatalogPage implements ICatalogPage 
    {

        protected static const var_1883:String = "ctlg_";

        protected var var_3286:XML;
        protected var _window:IWindowContainer;
        private var _viewer:ICatalogViewer;
        private var var_3079:int;
        private var var_3287:String;
        private var _offers:Array;
        private var _localization:IPageLocalization;
        private var var_3288:Array = [];
        private var var_3289:EventDispatcher;
        private var _catalog:HabboCatalog;
        private var var_3290:ItemGridCatalogWidget;

        public function CatalogPage(param1:ICatalogViewer, param2:int, param3:String, param4:IPageLocalization, param5:Array, param6:HabboCatalog)
        {
            var _loc7_:CatalogPageMessageOfferData;
            var _loc8_:Array;
            var _loc9_:IProductData;
            var _loc10_:CatalogPageMessageProductData;
            var _loc11_:Offer;
            var _loc12_:IFurnitureData;
            var _loc13_:Product;
            super();
            this._viewer = param1;
            this.var_3079 = param2;
            this.var_3287 = param3;
            this._localization = param4;
            this._offers = new Array();
            this._catalog = param6;
            for each (_loc7_ in param5)
            {
                _loc8_ = new Array();
                _loc9_ = this._viewer.catalog.getProductData(_loc7_.localizationId);
                for each (_loc10_ in _loc7_.products)
                {
                    _loc12_ = this._viewer.catalog.getFurnitureData(_loc10_.furniClassId, _loc10_.productType);
                    _loc13_ = new Product(_loc10_.productType, _loc10_.furniClassId, _loc10_.extraParam, _loc10_.productCount, _loc10_.expiration, _loc9_, _loc12_);
                    _loc8_.push(_loc13_);
                };
                _loc11_ = new Offer(_loc7_.offerId, _loc7_.localizationId, _loc7_.priceInCredits, _loc7_.priceInActivityPoints, _loc7_.activityPointType, _loc7_.clubLevel, _loc8_, this);
                if (_loc11_.productContainer != null)
                {
                    this._offers.push(_loc11_);
                }
                else
                {
                    _loc11_.dispose();
                };
            };
            this.var_3289 = new EventDispatcher();
            this.var_3288 = new Array();
            this.init();
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function get viewer():ICatalogViewer
        {
            return (this._viewer);
        }

        public function get pageId():int
        {
            return (this.var_3079);
        }

        public function get layoutCode():String
        {
            return (this.var_3287);
        }

        public function get offers():Array
        {
            return (this._offers);
        }

        public function get localization():IPageLocalization
        {
            return (this._localization);
        }

        public function get links():Array
        {
            return (this._localization.getLinks(this.var_3287));
        }

        public function get hasLinks():Boolean
        {
            return (this._localization.hasLinks(this.var_3287));
        }

        public function selectOffer(param1:int):void
        {
            var _loc2_:Offer;
            var _loc3_:IGridItem;
            if (this.var_3290 != null)
            {
                Logger.log(("selecting offer " + param1));
                for each (_loc2_ in this._offers)
                {
                    if (_loc2_.offerId == param1)
                    {
                        _loc3_ = (_loc2_.productContainer as IGridItem);
                        this.var_3290.select(_loc3_);
                    };
                };
            };
        }

        public function dispose():void
        {
            var _loc1_:ICatalogWidget;
            var _loc2_:Offer;
            for each (_loc1_ in this.var_3288)
            {
                _loc1_.dispose();
            };
            this.var_3288 = null;
            this._localization.dispose();
            for each (_loc2_ in this._offers)
            {
                _loc2_.dispose();
            };
            this._offers = [];
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_3289 != null)
            {
                this.var_3289.dispose();
                this.var_3289 = null;
            };
            this._viewer = null;
            this.var_3286 = null;
            this.var_3079 = 0;
            this.var_3287 = "";
        }

        public function init():void
        {
            if (this.createWindow(this.layoutCode))
            {
                this.createWidgets();
            };
        }

        public function closed():void
        {
            var _loc1_:ICatalogWidget;
            if (this.var_3288 != null)
            {
                for each (_loc1_ in this.var_3288)
                {
                    _loc1_.closed();
                };
            };
        }

        protected function createWindow(param1:String):Boolean
        {
            var _loc2_:String = (var_1883 + param1);
            var _loc3_:XmlAsset = (this.viewer.catalog.assets.getAssetByName(_loc2_) as XmlAsset);
            if (_loc3_ == null)
            {
                Logger.log(("Could not find asset for layout " + _loc2_));
                return (false);
            };
            this.var_3286 = (_loc3_.content as XML);
            this._window = (this.viewer.catalog.windowManager.buildFromXML(this.var_3286) as IWindowContainer);
            if (this._window == null)
            {
                Logger.log(("Could not create layout " + param1));
                return (false);
            };
            return (true);
        }

        private function localize():void
        {
        }

        private function createWidgets():void
        {
            this.createWidgetsRecursion(this._window);
            this.initializeWidgets();
        }

        private function createWidgetsRecursion(param1:IWindowContainer):void
        {
            var _loc2_:int;
            var _loc3_:IWindowContainer;
            if (param1 != null)
            {
                _loc2_ = 0;
                while (_loc2_ < param1.numChildren)
                {
                    _loc3_ = (param1.getChildAt(_loc2_) as IWindowContainer);
                    if (_loc3_ != null)
                    {
                        this.createWidget(_loc3_);
                        this.createWidgetsRecursion(_loc3_);
                    };
                    _loc2_++;
                };
            };
        }

        private function createWidget(param1:IWindowContainer):void
        {
            if (param1 == null)
            {
                return;
            };
            switch (param1.name)
            {
                case CatalogWidgetEnum.var_1884:
                    if (this.var_3290 == null)
                    {
                        this.var_3290 = new ItemGridCatalogWidget(param1, this._catalog.sessionDataManager);
                        this.var_3288.push(this.var_3290);
                    };
                    return;
                case CatalogWidgetEnum.var_1885:
                    this.var_3288.push(new ItemGroupCatalogWidget(param1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum.var_1886:
                    this.var_3288.push(new ProductViewCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1887:
                    this.var_3288.push(new SongDiskProductViewCatalogWidget(param1, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum.var_1888:
                    this.var_3288.push(new SingleViewCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1889:
                    this.var_3288.push(new PurchaseCatalogWidget(param1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum.var_1890:
                    this.var_3288.push(new PurseCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1891:
                    this.var_3288.push(new ColourGridCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1892:
                    this.var_3288.push(new TraxPreviewCatalogWidget(param1, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum.var_1893:
                    this.var_3288.push(new RedeemItemCodeCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1894:
                    this.var_3288.push(new SpacesCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1895:
                    this.var_3288.push(new SpacesNewCatalogWidget(param1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum.var_1896:
                    this.var_3288.push(new RoomPreviewCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1897:
                    this.var_3288.push(new TrophyCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1898:
                    this.var_3288.push(new PetsCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1899:
                    this.var_3288.push(new NewPetsCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1900:
                    this.var_3288.push(new TextInputCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1901:
                    this.var_3288.push(new SpecialInfoWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1902:
                    this.var_3288.push(new RecyclerCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1903:
                    this.var_3288.push(new RecyclerPrizesCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1904:
                    this.var_3288.push(new MarketPlaceCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1905:
                    this.var_3288.push(new MarketPlaceOwnItemsCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1906:
                    this.var_3288.push(new ClubGiftWidget(param1, this._catalog.getClubGiftController()));
                    return;
                case CatalogWidgetEnum.var_1907:
                    this.var_3288.push(new ClubBuyCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1908:
                    this.var_3288.push(new ActivityPointDisplayCatalogWidget(param1));
                    return;
                case CatalogWidgetEnum.var_1909:
                    this.var_3288.push(new MadMoneyCatalogWidget(param1));
                    return;
            };
        }

        private function initializeWidgets():void
        {
            var _loc1_:ICatalogWidget;
            var _loc2_:Array = [];
            for each (_loc1_ in this.var_3288)
            {
                _loc1_.page = this;
                _loc1_.events = this.var_3289;
                if (!_loc1_.init())
                {
                    _loc2_.push(_loc1_);
                };
            };
            this.removeWidgets(_loc2_);
            this.initializeLocalizations();
            this.var_3289.dispatchEvent(new CatalogWidgetsInitializedEvent());
        }

        private function initializeLocalizations():void
        {
            var _loc1_:ICatalogWidget = new LocalizationCatalogWidget(this._window);
            this.var_3288.push(_loc1_);
            _loc1_.page = this;
            _loc1_.events = this.var_3289;
            _loc1_.init();
        }

        private function removeWidgets(param1:Array):void
        {
            var _loc2_:ICatalogWidget;
            var _loc3_:ICatalogWidget;
            var _loc4_:int;
            if (((param1 == null) || (param1.length == 0)))
            {
                return;
            };
            for each (_loc2_ in this.var_3288)
            {
                if (_loc2_.window != null)
                {
                    for each (_loc3_ in param1)
                    {
                        if (_loc3_.window != null)
                        {
                            if (_loc3_.window.getChildIndex(_loc2_.window) >= 0)
                            {
                                if (param1.indexOf(_loc2_) < 0)
                                {
                                    param1.push(_loc2_);
                                };
                                break;
                            };
                        };
                    };
                };
            };
            for each (_loc3_ in param1)
            {
                if (_loc3_.window != null)
                {
                    this._window.removeChild(_loc3_.window);
                    _loc3_.window.dispose();
                };
                _loc4_ = this.var_3288.indexOf(_loc3_);
                if (_loc4_ >= 0)
                {
                    this.var_3288.splice(_loc4_, 1);
                };
                _loc3_.dispose();
            };
        }

        public function dispatchWidgetEvent(param1:Event):Boolean
        {
            if (this.var_3289 != null)
            {
                return (this.var_3289.dispatchEvent(param1));
            };
            return (false);
        }

        public function replaceOffers(param1:Array, param2:Boolean=false):void
        {
            var _loc3_:Offer;
            if (param2)
            {
                for each (_loc3_ in this._offers)
                {
                    _loc3_.dispose();
                };
            };
            this._offers = param1;
        }


    }
}