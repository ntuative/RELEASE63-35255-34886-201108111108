package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class DimmerViewAlphaSlider 
    {

        private var _view:DimmerView;
        private var _sliderContainer:IWindowContainer;
        private var var_4946:BitmapData;
        private var var_4947:BitmapData;
        private var var_4948:int;
        private var var_5289:int;
        private var _minValue:int = 0;
        private var var_4949:int = 0xFF;

        public function DimmerViewAlphaSlider(param1:DimmerView, param2:IWindowContainer, param3:IAssetLibrary, param4:int=0, param5:int=0xFF)
        {
            this._view = param1;
            this._sliderContainer = param2;
            this._minValue = param4;
            this.var_4949 = param5;
            this.storeAssets(param3);
            this.displaySlider();
        }

        public function dispose():void
        {
            this._view = null;
            this._sliderContainer = null;
            this.var_4946 = null;
            this.var_4947 = null;
        }

        public function setValue(param1:int):void
        {
            if (this._sliderContainer == null)
            {
                return;
            };
            var _loc2_:IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_loc2_ != null)
            {
                _loc2_.x = this.getSliderPosition(param1);
            };
        }

        public function set min(param1:Number):void
        {
            this._minValue = param1;
            this.setValue(this._view.selectedBrightness);
        }

        public function set max(param1:Number):void
        {
            this.var_4949 = param1;
            this.setValue(this._view.selectedBrightness);
        }

        private function getSliderPosition(param1:int):int
        {
            return (int((this.var_4948 * (Number((param1 - this._minValue)) / (this.var_4949 - this._minValue)))));
        }

        private function getValue(param1:Number):int
        {
            return (int(((param1 / this.var_4948) * (this.var_4949 - this._minValue))) + this._minValue);
        }

        private function buttonProcedure(param1:WindowEvent, param2:IWindow):void
        {
            if (((!(param1.type == WindowMouseEvent.var_655)) && (!(param1.type == WindowMouseEvent.var_656))))
            {
                return;
            };
            this._view.selectedBrightness = this.getValue(param2.x);
        }

        private function displaySlider():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:IBitmapWrapperWindow;
            if (this._sliderContainer == null)
            {
                return;
            };
            _loc2_ = (this._sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!(_loc2_ == null)) && (!(this.var_4946 == null))))
            {
                _loc2_.bitmap = new BitmapData(this.var_4946.width, this.var_4946.height, true, 0xFFFFFF);
                _loc2_.bitmap.copyPixels(this.var_4946, this.var_4946.rect, new Point(0, 0), null, null, true);
            };
            _loc1_ = (this._sliderContainer.findChildByName("slider_movement_area") as IWindowContainer);
            if (_loc1_ != null)
            {
                _loc2_ = (_loc1_.findChildByName("slider_button") as IBitmapWrapperWindow);
                if (((!(_loc2_ == null)) && (!(this.var_4947 == null))))
                {
                    _loc2_.bitmap = new BitmapData(this.var_4947.width, this.var_4947.height, true, 0xFFFFFF);
                    _loc2_.bitmap.copyPixels(this.var_4947, this.var_4947.rect, new Point(0, 0), null, null, true);
                    _loc2_.procedure = this.buttonProcedure;
                    this.var_4948 = (_loc1_.width - _loc2_.width);
                };
            };
        }

        private function storeAssets(param1:IAssetLibrary):void
        {
            var _loc2_:BitmapDataAsset;
            if (param1 == null)
            {
                return;
            };
            _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_base"));
            this.var_4946 = BitmapData(_loc2_.content);
            _loc2_ = BitmapDataAsset(param1.getAssetByName("dimmer_slider_button"));
            this.var_4947 = BitmapData(_loc2_.content);
        }


    }
}