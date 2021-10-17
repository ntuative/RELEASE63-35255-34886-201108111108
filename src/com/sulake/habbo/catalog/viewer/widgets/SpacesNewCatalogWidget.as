package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, ICatalogWidget, IItemGrid 
    {

        private var _groupNames:Array = ["wallpaper", "floor", "landscape"];
        private var var_3203:Array = new Array();
        private var var_3204:int = 0;
        private var var_3205:Array = [0, 0, 0];
        private var var_3281:ISelectorWindow;
        private var var_534:Array = ["group.walls", "group.floors", "group.views"];

        public function SpacesNewCatalogWidget(param1:IWindowContainer, param2:ISessionDataManager)
        {
            var _loc3_:int;
            var _loc4_:IWindow;
            super(param1, param2);
            this.var_3281 = (_window.findChildByName("groups") as ISelectorWindow);
            if (this.var_3281)
            {
                _loc3_ = 0;
                while (_loc3_ < this.var_3281.numSelectables)
                {
                    _loc4_ = this.var_3281.getSelectableAt(_loc3_);
                    if ((_loc4_ is ISelectableWindow))
                    {
                        _loc4_.addEventListener(WindowEvent.var_576, this.onSelectGroup);
                    };
                    _loc3_++;
                };
            };
        }

        override public function dispose():void
        {
            var _loc1_:Array;
            var _loc2_:Offer;
            super.dispose();
            for each (_loc1_ in this.var_3203)
            {
                for each (_loc2_ in _loc1_)
                {
                    _loc2_.dispose();
                };
            };
            this.var_3203 = null;
        }

        override public function init():Boolean
        {
            Logger.log("Init Item Group Catalog Widget (Spaces New)");
            this.createOfferGroups();
            if (!super.init())
            {
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            this.switchCategory(this.var_534[this.var_3204]);
            this.updateRoomPreview();
            return (true);
        }

        public function onWidgetsInitialized(param1:CatalogWidgetsInitializedEvent):void
        {
            var _loc2_:int = this.var_3205[this.var_3204];
            var _loc3_:Offer = this.var_3203[this.var_3204][_loc2_];
            this.select((_loc3_.productContainer as IGridItem));
        }

        public function selectIndex(param1:int):void
        {
            var _loc2_:Offer;
            if (((param1 > -1) && (param1 < var_2484.numGridItems)))
            {
                _loc2_ = this.var_3203[this.var_3204][param1];
                this.select((_loc2_.productContainer as IGridItem));
            };
        }

        override public function select(param1:IGridItem):void
        {
            if (param1 == null)
            {
                return;
            };
            super.select(param1);
            var _loc2_:Offer = (param1 as ProductContainer).offer;
            if (_loc2_ == null)
            {
                return;
            };
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_loc2_.productContainer.firstProduct.extraParam));
            this.var_3205[this.var_3204] = (this.var_3203[this.var_3204] as Array).indexOf(_loc2_);
            this.updateRoomPreview();
        }

        private function updateRoomPreview():void
        {
            var _loc1_:int = this.var_3205[0];
            var _loc2_:int = this.var_3205[1];
            var _loc3_:int = this.var_3205[2];
            var _loc4_:Offer = this.var_3203[0][_loc1_];
            var _loc5_:Offer = this.var_3203[1][_loc2_];
            var _loc6_:Offer = this.var_3203[2][_loc3_];
            if ((((!(_loc5_)) || (!(_loc4_))) || (!(_loc6_))))
            {
                return;
            };
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_loc5_.productContainer.firstProduct.extraParam, _loc4_.productContainer.firstProduct.extraParam, _loc6_.productContainer.firstProduct.extraParam, 64));
        }

        private function createOfferGroups():Boolean
        {
            var _loc1_:Offer;
            var _loc2_:IProduct;
            var _loc3_:int;
            var _loc4_:String;
            var _loc5_:int;
            for each (_loc1_ in page.offers)
            {
                if (((_loc1_.pricingModel == Offer.var_813) || (_loc1_.pricingModel == Offer.var_814)))
                {
                    _loc2_ = _loc1_.productContainer.firstProduct;
                    if (_loc2_ != null)
                    {
                        _loc3_ = _loc2_.productClassId;
                        if (((_loc2_.productType == ProductTypeEnum.var_106) || (_loc2_.productType == ProductTypeEnum.var_105)))
                        {
                            if (_loc2_.furnitureData != null)
                            {
                                _loc4_ = _loc2_.furnitureData.name;
                                _loc5_ = this._groupNames.indexOf(_loc4_);
                                if (this._groupNames.indexOf(_loc4_) == -1)
                                {
                                    this._groupNames.push(_loc4_);
                                };
                                while (this.var_3203.length < this._groupNames.length)
                                {
                                    this.var_3203.push(new Array());
                                };
                                switch (_loc4_)
                                {
                                    case "floor":
                                        (this.var_3203[_loc5_] as Array).push(_loc1_);
                                        break;
                                    case "wallpaper":
                                        (this.var_3203[_loc5_] as Array).push(_loc1_);
                                        break;
                                    case "landscape":
                                        (this.var_3203[_loc5_] as Array).push(_loc1_);
                                        break;
                                    default:
                                        Logger.log(("[SpacesCatalogWidget] : " + _loc4_));
                                };
                            };
                        };
                    };
                };
            };
            page.replaceOffers([], false);
            return (true);
        }

        private function onSelectGroup(param1:WindowEvent):void
        {
            var _loc3_:int;
            var _loc2_:ISelectableWindow = (param1.target as ISelectableWindow);
            if (_loc2_)
            {
                _loc3_ = this.var_3281.getSelectableIndex(_loc2_);
                Logger.log(("select: " + [_loc2_.name, _loc3_]));
                this.switchCategory(_loc2_.name);
            };
        }

        private function switchCategory(param1:String):void
        {
            var _loc3_:int;
            if (disposed)
            {
                return;
            };
            if (!this.var_3281)
            {
                return;
            };
            this.var_3281.setSelected(this.var_3281.getSelectableByName(param1));
            var _loc2_:int = -1;
            switch (param1)
            {
                case "group.walls":
                    _loc2_ = 0;
                    break;
                case "group.floors":
                    _loc2_ = 1;
                    break;
                case "group.views":
                    _loc2_ = 2;
                    break;
                default:
                    _loc2_ = -1;
            };
            if (_loc2_ > -1)
            {
                if (var_2485 != null)
                {
                    var_2485.deActivate();
                };
                var_2485 = null;
                this.var_3204 = _loc2_;
                if (var_2484)
                {
                    var_2484.destroyGridItems();
                };
                page.replaceOffers(this.var_3203[this.var_3204], false);
                resetTimer();
                populateItemGrid();
                loadItemGridGraphics();
                if (var_2486)
                {
                    var_2486.start();
                };
                _loc3_ = this.var_3205[this.var_3204];
                this.selectIndex(_loc3_);
            };
        }


    }
}