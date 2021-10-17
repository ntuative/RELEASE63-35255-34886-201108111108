package com.sulake.habbo.inventory
{
    import flash.utils.Timer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ItemPopupCtrl 
    {

        public static const var_2503:int = 1;
        public static const var_2081:int = 2;
        private static const var_2508:int = 5;
        private static const var_2504:int = 250;
        private static const var_2505:int = 100;
        private static const var_2506:int = 180;
        private static const var_2507:int = 200;

        private var var_4132:Timer = new Timer(var_2504, 1);
        private var var_4133:Timer = new Timer(var_2505, 1);
        private var _assets:IAssetLibrary;
        private var var_4131:IWindowContainer;
        private var _parent:IWindowContainer;
        private var var_4134:int = 2;
        private var var_4135:BitmapData;
        private var var_4136:BitmapData;

        public function ItemPopupCtrl(param1:IWindowContainer, param2:IAssetLibrary)
        {
            if (param1 == null)
            {
                return;
            };
            if (param2 == null)
            {
                return;
            };
            this.var_4131 = param1;
            this.var_4131.visible = false;
            this._assets = param2;
            this.var_4132.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this.var_4133.addEventListener(TimerEvent.TIMER, this.onHideTimer);
            var _loc3_:BitmapDataAsset = (this._assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset);
            if (((!(_loc3_ == null)) && (!(_loc3_.content == null))))
            {
                this.var_4136 = (_loc3_.content as BitmapData);
            };
            _loc3_ = (this._assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset);
            if (((!(_loc3_ == null)) && (!(_loc3_.content == null))))
            {
                this.var_4135 = (_loc3_.content as BitmapData);
            };
        }

        public function dispose():void
        {
            if (this.var_4132 != null)
            {
                this.var_4132.removeEventListener(TimerEvent.TIMER, this.onDisplayTimer);
                this.var_4132.stop();
                this.var_4132 = null;
            };
            if (this.var_4133 != null)
            {
                this.var_4133.removeEventListener(TimerEvent.TIMER, this.onHideTimer);
                this.var_4133.stop();
                this.var_4133 = null;
            };
            this._assets = null;
            this.var_4131 = null;
            this._parent = null;
            this.var_4135 = null;
            this.var_4136 = null;
        }

        public function updateContent(param1:IWindowContainer, param2:String, param3:BitmapData, param4:int=2):void
        {
            var _loc7_:BitmapData;
            if (this.var_4131 == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (param3 == null)
            {
                param3 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (this._parent != null)
            {
                this._parent.removeChild(this.var_4131);
            };
            this._parent = param1;
            this.var_4134 = param4;
            var _loc5_:ITextWindow = ITextWindow(this.var_4131.findChildByName("item_name_text"));
            if (_loc5_)
            {
                _loc5_.text = param2;
            };
            var _loc6_:IBitmapWrapperWindow = (this.var_4131.findChildByName("item_image") as IBitmapWrapperWindow);
            if (_loc6_)
            {
                _loc7_ = new BitmapData(Math.min(var_2506, param3.width), Math.min(var_2507, param3.height), true, 0xFFFFFF);
                _loc7_.copyPixels(param3, new Rectangle(0, 0, _loc7_.width, _loc7_.height), new Point(0, 0), null, null, true);
                _loc6_.bitmap = _loc7_;
                _loc6_.width = _loc6_.bitmap.width;
                _loc6_.height = _loc6_.bitmap.height;
                _loc6_.x = ((this.var_4131.width - _loc6_.width) / 2);
                this.var_4131.height = (_loc6_.rectangle.bottom + 10);
            };
        }

        public function show():void
        {
            this.var_4133.reset();
            this.var_4132.reset();
            if (this._parent == null)
            {
                return;
            };
            this.var_4131.visible = true;
            this._parent.addChild(this.var_4131);
            this.refreshArrow(this.var_4134);
            switch (this.var_4134)
            {
                case var_2503:
                    this.var_4131.x = ((-1 * this.var_4131.width) - var_2508);
                    break;
                case var_2081:
                    this.var_4131.x = (this._parent.width + var_2508);
                    break;
            };
            this.var_4131.y = ((this._parent.height - this.var_4131.height) / 2);
        }

        public function hide():void
        {
            this.var_4131.visible = false;
            this.var_4133.reset();
            this.var_4132.reset();
            if (this._parent != null)
            {
                this._parent.removeChild(this.var_4131);
            };
        }

        public function showDelayed():void
        {
            this.var_4133.reset();
            this.var_4132.reset();
            this.var_4132.start();
        }

        public function hideDelayed():void
        {
            this.var_4133.reset();
            this.var_4132.reset();
            this.var_4133.start();
        }

        private function refreshArrow(param1:int=2):void
        {
            if (((this.var_4131 == null) || (this.var_4131.disposed)))
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_4131.findChildByName("arrow_pointer"));
            if (!_loc2_)
            {
                return;
            };
            switch (param1)
            {
                case var_2503:
                    _loc2_.bitmap = this.var_4136.clone();
                    _loc2_.width = this.var_4136.width;
                    _loc2_.height = this.var_4136.height;
                    _loc2_.y = ((this.var_4131.height - this.var_4136.height) / 2);
                    _loc2_.x = (this.var_4131.width - 1);
                    break;
                case var_2081:
                    _loc2_.bitmap = this.var_4135.clone();
                    _loc2_.width = this.var_4135.width;
                    _loc2_.height = this.var_4135.height;
                    _loc2_.y = ((this.var_4131.height - this.var_4135.height) / 2);
                    _loc2_.x = ((-1 * this.var_4135.width) + 1);
                    break;
            };
            _loc2_.invalidate();
        }

        private function onDisplayTimer(param1:TimerEvent):void
        {
            this.show();
        }

        private function onHideTimer(param1:TimerEvent):void
        {
            this.hide();
        }


    }
}