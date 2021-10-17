package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.core.window.components.IItemGridWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;

    public class DimmerViewColorGrid 
    {

        private var var_5290:IItemGridWindow;
        private var _view:DimmerView;
        private var var_5291:XML;
        private var var_5292:BitmapData;
        private var var_5293:BitmapData;
        private var var_5294:BitmapData;
        private var var_2485:IWindowContainer;

        public function DimmerViewColorGrid(param1:DimmerView, param2:IItemGridWindow, param3:IHabboWindowManager, param4:IAssetLibrary)
        {
            this._view = param1;
            this.var_5290 = param2;
            this.storeAssets(param4);
            this.populate(param3);
        }

        public function dispose():void
        {
            this._view = null;
            this.var_5290 = null;
            this.var_5291 = null;
            this.var_5292 = null;
            this.var_5293 = null;
            this.var_5294 = null;
        }

        public function setSelectedColorIndex(param1:int):void
        {
            if (this.var_5290 == null)
            {
                return;
            };
            if (((param1 < 0) || (param1 >= this.var_5290.numGridItems)))
            {
                return;
            };
            this.select((this.var_5290.getGridItemAt(param1) as IWindowContainer));
        }

        private function populate(param1:IHabboWindowManager):void
        {
            if (((this._view == null) || (this.var_5290 == null)))
            {
                return;
            };
            this.populateColourGrid(param1);
        }

        private function select(param1:IWindowContainer):void
        {
            var _loc2_:IWindow;
            if (this.var_2485 != null)
            {
                _loc2_ = this.var_2485.getChildByName("chosen");
                if (_loc2_ != null)
                {
                    _loc2_.visible = false;
                };
            };
            this.var_2485 = param1;
            _loc2_ = this.var_2485.getChildByName("chosen");
            if (_loc2_ != null)
            {
                _loc2_.visible = true;
            };
        }

        private function populateColourGrid(param1:IHabboWindowManager):void
        {
            var _loc2_:uint;
            var _loc3_:IWindowContainer;
            var _loc4_:IBitmapWrapperWindow;
            var _loc5_:IBitmapWrapperWindow;
            var _loc6_:IBitmapWrapperWindow;
            var _loc7_:uint;
            var _loc8_:uint;
            var _loc9_:uint;
            var _loc10_:Number;
            var _loc11_:Number;
            var _loc12_:Number;
            var _loc13_:ColorTransform;
            var _loc14_:BitmapData;
            this.var_5290.destroyGridItems();
            this.var_2485 = null;
            for each (_loc2_ in this.colors)
            {
                _loc3_ = (param1.buildFromXML(this.var_5291) as IWindowContainer);
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClick);
                _loc3_.background = true;
                _loc3_.color = 0xFFFFFFFF;
                _loc3_.width = this.var_5292.width;
                _loc3_.height = this.var_5292.height;
                this.var_5290.addGridItem(_loc3_);
                _loc4_ = (_loc3_.findChildByTag("BG_BORDER") as IBitmapWrapperWindow);
                if (_loc4_ != null)
                {
                    _loc4_.bitmap = new BitmapData(this.var_5292.width, this.var_5292.height, true, 0);
                    _loc4_.bitmap.copyPixels(this.var_5292, this.var_5292.rect, new Point(0, 0));
                };
                _loc5_ = (_loc3_.findChildByTag("COLOR_IMAGE") as IBitmapWrapperWindow);
                if (_loc5_ != null)
                {
                    _loc5_.bitmap = new BitmapData(this.var_5293.width, this.var_5293.height, true, 0);
                    _loc7_ = ((_loc2_ >> 16) & 0xFF);
                    _loc8_ = ((_loc2_ >> 8) & 0xFF);
                    _loc9_ = ((_loc2_ >> 0) & 0xFF);
                    _loc10_ = ((_loc7_ / 0xFF) * 1);
                    _loc11_ = ((_loc8_ / 0xFF) * 1);
                    _loc12_ = ((_loc9_ / 0xFF) * 1);
                    _loc13_ = new ColorTransform(_loc10_, _loc11_, _loc12_);
                    _loc14_ = this.var_5293.clone();
                    _loc14_.colorTransform(_loc14_.rect, _loc13_);
                    _loc5_.bitmap.copyPixels(_loc14_, _loc14_.rect, new Point(0, 0));
                };
                _loc6_ = (_loc3_.findChildByTag("COLOR_CHOSEN") as IBitmapWrapperWindow);
                if (_loc6_ != null)
                {
                    _loc6_.bitmap = new BitmapData(this.var_5294.width, this.var_5294.height, true, 0xFFFFFF);
                    _loc6_.bitmap.copyPixels(this.var_5294, this.var_5294.rect, new Point(0, 0), null, null, true);
                    _loc6_.visible = false;
                };
            };
        }

        private function onClick(param1:WindowMouseEvent):void
        {
            var _loc2_:int = this.var_5290.getGridItemIndex((param1.target as IWindow));
            this.setSelectedColorIndex(_loc2_);
            this._view.selectedColorIndex = _loc2_;
        }

        private function storeAssets(param1:IAssetLibrary):void
        {
            var _loc2_:XmlAsset;
            var _loc3_:BitmapDataAsset;
            if (param1 == null)
            {
                return;
            };
            _loc2_ = XmlAsset(param1.getAssetByName("dimmer_color_chooser_cell"));
            this.var_5291 = XML(_loc2_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_frame"));
            this.var_5292 = BitmapData(_loc3_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_button"));
            this.var_5293 = BitmapData(_loc3_.content);
            _loc3_ = BitmapDataAsset(param1.getAssetByName("dimmer_color_selected"));
            this.var_5294 = BitmapData(_loc3_.content);
        }

        private function get colors():Array
        {
            if (this._view == null)
            {
                return ([]);
            };
            return (this._view.colors);
        }


    }
}