package com.sulake.habbo.catalog.viewer
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class BundleProductContainer extends ProductContainer implements IItemGrid 
    {

        private static const var_1875:int = 6;

        private var var_3285:BitmapData;

        public function BundleProductContainer(param1:Offer, param2:Array)
        {
            super(param1, param2);
            var _loc3_:BitmapDataAsset = (param1.page.viewer.catalog.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset);
            if (_loc3_ != null)
            {
                this.var_3285 = (_loc3_.content as BitmapData);
            }
            else
            {
                this.var_3285 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            this.var_3285 = null;
            super.dispose();
        }

        override public function initProductIcon(param1:IRoomEngine):void
        {
            setIconImage(this.var_3285.clone(), true);
        }

        public function populateItemGrid(param1:IItemGridWindow, param2:IScrollbarWindow, param3:XML):void
        {
            var _loc4_:IProduct;
            var _loc5_:IWindowContainer;
            var _loc6_:IBorderWindow;
            var _loc7_:BitmapData;
            var _loc8_:IIconWindow;
            for each (_loc4_ in offer.productContainer.products)
            {
                _loc5_ = (offer.page.viewer.catalog.windowManager.buildFromXML(param3) as IWindowContainer);
                _loc6_ = (_loc5_.findChildByName("bg") as IBorderWindow);
                if (_loc6_ != null)
                {
                    _loc8_ = (_loc6_.findChildByName("clubLevelIcon") as IIconWindow);
                    if (_loc8_ != null)
                    {
                        _loc8_.visible = false;
                    };
                };
                param1.addGridItem(_loc5_);
                _loc4_.view = _loc5_;
                _loc7_ = _loc4_.initIcon(this);
                if (_loc7_ != null)
                {
                    _loc7_.dispose();
                };
                _loc4_.grid = this;
            };
            if (param2 != null)
            {
                param2.visible = (offer.productContainer.products.length > var_1875);
            };
        }

        public function setBundleCounter(param1:int):void
        {
            var _loc2_:ITextWindow = (_view.findChildByName("bundleCounter") as ITextWindow);
            if (_loc2_ != null)
            {
                _loc2_.text = (param1 + "");
            };
        }

        public function select(param1:IGridItem):void
        {
            Logger.log(("Product Bundle, select item: " + param1));
        }

        public function startDragAndDrop(param1:IGridItem):Boolean
        {
            return (false);
        }


    }
}