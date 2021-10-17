package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class ProgressBar implements IDisposable 
    {

        private static const var_2212:int = 3;
        private static const var_2211:int = 10;

        private var var_4407:HabboQuestEngine;
        private var _window:IWindowContainer;
        private var var_4446:int;
        private var var_4447:String;
        private var var_4448:Boolean;
        private var var_4449:int;
        private var var_4450:int;
        private var var_4451:int;
        private var var_4452:int;
        private var var_4453:int;
        private var var_4454:Boolean;
        private var var_4455:BitmapData;
        private var var_4445:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        private var var_4456:ColorMatrixFilter = new ColorMatrixFilter(var_4445);

        public function ProgressBar(param1:HabboQuestEngine, param2:IWindowContainer, param3:int, param4:String, param5:Boolean, param6:Point)
        {
            this.var_4407 = param1;
            this._window = param2;
            this.var_4446 = param3;
            this.var_4447 = param4;
            this.var_4448 = param5;
            var _loc7_:IWindowContainer = IWindowContainer(this._window.findChildByName("progress_bar_cont"));
            if (_loc7_ == null)
            {
                _loc7_ = IWindowContainer(this.var_4407.getXmlWindow("ProgressBar"));
                this._window.addChild(_loc7_);
                _loc7_.x = param6.x;
                _loc7_.y = param6.y;
                _loc7_.width = (this.var_4446 + var_2211);
            };
            if (param5)
            {
                new PendingImage(this.var_4407, this._window.findChildByName("bar_l"), "ach_progressbar1");
                new PendingImage(this.var_4407, this._window.findChildByName("bar_c"), "ach_progressbar2");
                new PendingImage(this.var_4407, this._window.findChildByName("bar_r"), "ach_progressbar3");
            };
            new PendingImage(this.var_4407, this._window.findChildByName("bar_a_c"), "ach_progressbar4");
            new PendingImage(this.var_4407, this._window.findChildByName("bar_a_r"), "ach_progressbar5");
        }

        public function refresh(param1:int, param2:int, param3:int):void
        {
            var _loc4_:Boolean = ((!(param3 == this.var_4451)) || (!(param2 == this.var_4450)));
            this.var_4450 = param2;
            this.var_4449 = param1;
            this.var_4452 = this.var_4453;
            this.var_4451 = param3;
            if (_loc4_)
            {
                this.var_4453 = this.getProgressWidth(this.var_4449);
            };
            this.var_4454 = true;
            this.updateView();
        }

        public function set visible(param1:Boolean):void
        {
            var _loc2_:IWindowContainer = IWindowContainer(this._window.findChildByName("progress_bar_cont"));
            if (_loc2_ != null)
            {
                _loc2_.visible = param1;
            };
        }

        public function updateView():void
        {
            var _loc7_:IBitmapWrapperWindow;
            var _loc8_:IBitmapWrapperWindow;
            var _loc9_:int;
            if (!this.var_4454)
            {
                return;
            };
            var _loc1_:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("bar_a_c"));
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(this._window.findChildByName("bar_a_r"));
            if (((_loc1_.bitmap == null) || (_loc2_.bitmap == null)))
            {
                return;
            };
            if (this.var_4448)
            {
                _loc7_ = IBitmapWrapperWindow(this._window.findChildByName("bar_c"));
                _loc8_ = IBitmapWrapperWindow(this._window.findChildByName("bar_r"));
                if (((_loc7_.bitmap == null) || (_loc8_.bitmap == null)))
                {
                    return;
                };
                _loc7_.width = this.var_4446;
                _loc8_.x = (this.var_4446 + _loc1_.x);
            };
            if (this.var_4455 == null)
            {
                this.var_4455 = _loc1_.bitmap.clone();
            };
            var _loc3_:int = this.getProgressWidth(this.var_4449);
            if (this.var_4453 < _loc3_)
            {
                _loc9_ = Math.min(Math.abs((this.var_4453 - _loc3_)), Math.abs((this.var_4452 - _loc3_)));
                this.var_4453 = Math.min(_loc3_, (this.var_4453 + Math.max(1, Math.round(Math.sqrt(_loc9_)))));
            };
            var _loc4_:* = (this.var_4453 > 0);
            _loc1_.visible = _loc4_;
            _loc2_.visible = _loc4_;
            if (_loc4_)
            {
                _loc1_.width = this.var_4455.width;
                if (this.var_4453 < _loc3_)
                {
                    this.changeProgressColorFilter();
                    _loc1_.bitmap.applyFilter(this.var_4455, this.var_4455.rect, new Point(0, 0), this.var_4456);
                }
                else
                {
                    _loc1_.bitmap.copyPixels(this.var_4455, this.var_4455.rect, new Point(0, 0), null, null, true);
                };
                _loc1_.width = this.var_4453;
                _loc2_.x = (this.var_4453 + _loc1_.x);
            };
            this.var_4454 = (this.var_4453 < _loc3_);
            var _loc5_:ITextWindow = ITextWindow(this._window.findChildByName("progress_txt"));
            var _loc6_:int = ((this.var_4454) ? int(Math.round(((this.var_4453 / this.var_4446) * this.var_4450))) : this.var_4449);
            this.var_4407.localization.registerParameter(this.var_4447, "progress", ("" + _loc6_));
            this.var_4407.localization.registerParameter(this.var_4447, "limit", ("" + this.var_4450));
            _loc5_.caption = this.var_4407.localization.getKey(this.var_4447, this.var_4447);
            _loc5_.x = ((var_2212 + _loc1_.x) + ((this.var_4446 - _loc5_.width) / 2));
        }

        public function dispose():void
        {
            this.var_4407 = null;
            this._window = null;
        }

        public function get disposed():Boolean
        {
            return (this.var_4407 == null);
        }

        private function getProgressWidth(param1:int):int
        {
            return (Math.max(0, Math.round(((this.var_4446 * param1) / this.var_4450))));
        }

        private function changeProgressColorFilter():void
        {
            var _loc1_:int = this.getProgressWidth(this.var_4449);
            var _loc2_:int = (_loc1_ - this.var_4452);
            if (_loc2_ == 0)
            {
                return;
            };
            var _loc3_:Number = ((_loc1_ - this.var_4453) / _loc2_);
            this.var_4445[3] = _loc3_;
            this.var_4445[8] = _loc3_;
            this.var_4445[0] = (1 - _loc3_);
            this.var_4445[6] = (1 - _loc3_);
            this.var_4445[12] = (1 - _loc3_);
            this.var_4456.matrix = this.var_4445;
        }


    }
}