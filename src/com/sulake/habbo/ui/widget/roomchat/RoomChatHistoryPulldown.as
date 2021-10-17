package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
    import flash.geom.Point;

    public class RoomChatHistoryPulldown 
    {

        public static const var_1863:int = 3;
        public static const var_1861:int = 2;
        public static const var_2343:int = 1;
        public static const var_2342:int = 0;
        public static const var_1648:int = 39;
        private static const var_2346:int = 150;
        private static const var_2345:int = 250;

        private var _widget:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;
        private var var_5416:IBitmapWrapperWindow;
        private var var_5415:IWindowContainer;
        private var _region:IRegionWindow;
        private var _assetLibrary:IAssetLibrary;
        private var var_5417:int = 0;
        private var _state:int = -1;
        private var var_5418:BitmapData;
        private var var_5419:BitmapData;
        private var var_5420:BitmapData;
        private var var_5421:BitmapData;
        private var var_5422:BitmapData;
        private var var_5423:BitmapData;
        private var var_5424:BitmapData;
        private var var_5425:int = 30;

        public function RoomChatHistoryPulldown(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IWindowContainer, param4:IAssetLibrary)
        {
            this._widget = param1;
            this._windowManager = param2;
            this._assetLibrary = param4;
            this.var_5415 = param3;
            this.var_5418 = ((this._assetLibrary.getAssetByName("chat_grapbar_bg") as BitmapDataAsset).content as BitmapData);
            this.var_5419 = ((this._assetLibrary.getAssetByName("chat_grapbar_grip") as BitmapDataAsset).content as BitmapData);
            this.var_5420 = ((this._assetLibrary.getAssetByName("chat_grapbar_handle") as BitmapDataAsset).content as BitmapData);
            this.var_5421 = ((this._assetLibrary.getAssetByName("chat_grapbar_x") as BitmapDataAsset).content as BitmapData);
            this.var_5422 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_hi") as BitmapDataAsset).content as BitmapData);
            this.var_5423 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_pr") as BitmapDataAsset).content as BitmapData);
            this.var_5424 = ((this._assetLibrary.getAssetByName("chat_history_bg") as BitmapDataAsset).content as BitmapData);
            this.var_5416 = (this._windowManager.createWindow("chat_history_bg", "", HabboWindowType.var_156, HabboWindowStyle.var_613, HabboWindowParam.var_159, new Rectangle(0, 0, param3.width, (param3.height - var_1648)), null, 0, 0) as IBitmapWrapperWindow);
            this.var_5415.addChild(this.var_5416);
            this._window = (this._windowManager.createWindow("chat_pulldown", "", HabboWindowType.var_218, HabboWindowStyle.var_613, (HabboWindowParam.var_158 | HabboWindowParam.var_159), new Rectangle(0, (this.var_5415.height - var_1648), param3.width, var_1648), null, 0) as IWindowContainer);
            this.var_5415.addChild(this._window);
            this._region = (this._windowManager.createWindow("REGIONchat_pulldown", "", WindowType.var_1120, HabboWindowStyle.var_157, (((HabboWindowParam.var_158 | HabboWindowParam.var_159) | HabboWindowParam.var_835) | HabboWindowParam.var_840), new Rectangle(0, 0, param3.width, (param3.height - var_1648)), null, 0) as IRegionWindow);
            if (this._region != null)
            {
                this._region.background = true;
                this._region.mouseThreshold = 0;
                this._region.addEventListener(WindowMouseEvent.var_650, this.onPulldownMouseDown);
                this.var_5415.addChild(this._region);
                this._region.toolTipCaption = "${chat.history.drag.tooltip}";
                this._region.toolTipDelay = 250;
            };
            var _loc5_:XmlAsset = (param4.getAssetByName("chat_history_pulldown") as XmlAsset);
            this._window.buildFromXML((_loc5_.content as XML));
            this._window.addEventListener(WindowMouseEvent.var_650, this.onPulldownMouseDown);
            var _loc6_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc6_ != null)
            {
                _loc6_.mouseThreshold = 0;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCloseButtonClicked);
                _loc6_.addEventListener(WindowMouseEvent.var_655, this.onCloseButtonMouseUp);
                _loc6_.addEventListener(WindowMouseEvent.var_650, this.onCloseButtonMouseDown);
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseButtonMouseOver);
                _loc6_.addEventListener(WindowMouseEvent.var_624, this.onCloseButtonMouseOut);
            };
            this._window.background = true;
            this._window.color = 0;
            this._window.mouseThreshold = 0;
            this.state = var_2342;
            this.buildWindowGraphics();
        }

        public function dispose():void
        {
            if (this._region != null)
            {
                this._region.dispose();
                this._region = null;
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5416 != null)
            {
                this.var_5416.dispose();
                this.var_5416 = null;
            };
        }

        public function update(param1:uint):void
        {
            switch (this.state)
            {
                case var_1861:
                    this.var_5416.blend = (this.var_5416.blend + (param1 / var_2345));
                    this._window.blend = (this._window.blend + (param1 / var_2345));
                    if (this._window.blend >= 1)
                    {
                        this.state = var_2343;
                    };
                    return;
                case var_1863:
                    this.var_5416.blend = (this.var_5416.blend - (param1 / var_2346));
                    this._window.blend = (this._window.blend - (param1 / var_2346));
                    if (this._window.blend <= 0)
                    {
                        this.state = var_2342;
                    };
                    return;
            };
        }

        public function set state(param1:int):void
        {
            if (param1 == this._state)
            {
                return;
            };
            switch (param1)
            {
                case var_2343:
                    if (this._state == var_2342)
                    {
                        this.state = var_1861;
                    }
                    else
                    {
                        if (((this._window == null) || (this.var_5416 == null)))
                        {
                            return;
                        };
                        this._window.visible = true;
                        this.var_5416.visible = true;
                        this._region.visible = true;
                        this._state = param1;
                    };
                    return;
                case var_2342:
                    if (((this._window == null) || (this.var_5416 == null)))
                    {
                        return;
                    };
                    this._window.visible = false;
                    this.var_5416.visible = false;
                    this._region.visible = false;
                    this._state = param1;
                    return;
                case var_1861:
                    if (((this._window == null) || (this.var_5416 == null)))
                    {
                        return;
                    };
                    this._window.blend = 0;
                    this.var_5416.blend = 0;
                    this._window.visible = true;
                    this.var_5416.visible = true;
                    this._state = param1;
                    return;
                case var_1863:
                    if (((this._window == null) || (this.var_5416 == null)))
                    {
                        return;
                    };
                    this._window.blend = 1;
                    this.var_5416.blend = 1;
                    this._state = param1;
                    return;
            };
        }

        public function get state():int
        {
            return (this._state);
        }

        public function containerResized(param1:Rectangle):void
        {
            if (this._window != null)
            {
                this._window.x = 0;
                this._window.y = (this.var_5415.height - var_1648);
                this._window.width = this.var_5415.width;
            };
            if (this._region != null)
            {
                this._region.x = 0;
                this._region.y = (this.var_5415.height - var_1648);
                this._region.width = (this.var_5415.width - this.var_5425);
            };
            if (this.var_5416 != null)
            {
                this.var_5416.rectangle = this.var_5415.rectangle;
                this.var_5416.height = (this.var_5416.height - var_1648);
            };
            this.buildWindowGraphics();
        }

        private function buildWindowGraphics():void
        {
            var width:int;
            var height:int;
            var state:int;
            var destBgBitmap:BitmapData;
            var destGripLBitmap:BitmapData;
            var destGripRBitmap:BitmapData;
            if (this._window == null)
            {
                return;
            };
            if (this.var_5417 == this._window.width)
            {
                return;
            };
            this.var_5417 = this._window.width;
            var barBg:IBitmapWrapperWindow = (this._window.findChildByName("grapBarBg") as IBitmapWrapperWindow);
            var barX:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            var barGripL:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripL") as IBitmapWrapperWindow);
            var barGripR:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripR") as IBitmapWrapperWindow);
            var barHandle:IBitmapWrapperWindow = (this._window.findChildByName("grapBarHandle") as IBitmapWrapperWindow);
            var gripMargin:int = 5;
            if (((!(barX == null)) && (!(barHandle == null))))
            {
                barHandle.bitmap = this.var_5420;
                barHandle.disposesBitmap = false;
                barX.bitmap = this.var_5421;
                barX.disposesBitmap = false;
                this.var_5425 = (this._window.width - barX.x);
            };
            barGripL.width = (barHandle.x - gripMargin);
            barGripL.x = 0;
            barGripR.x = ((barHandle.x + barHandle.width) + gripMargin);
            barGripR.width = ((barX.x - gripMargin) - barGripR.x);
            if (barGripL.width < 0)
            {
                barGripL.width = 0;
            };
            if (barGripR.width < 0)
            {
                barGripR.width = 0;
            };
            state = 0;
            if ((((!(barBg == null)) && (!(barGripL == null))) && (!(barGripR == null))))
            {
                try
                {
                    state = 1;
                    width = barBg.width;
                    height = barBg.height;
                    if (((width > 0) && (height > 0)))
                    {
                        destBgBitmap = new TrackedBitmapData(this, width, height);
                        this.tileBitmapHorz(this.var_5418, destBgBitmap);
                        barBg.disposesBitmap = true;
                        barBg.bitmap = destBgBitmap;
                    };
                    state = 2;
                    width = barGripL.width;
                    height = barGripL.height;
                    if (((width > 0) && (height > 0)))
                    {
                        destGripLBitmap = new TrackedBitmapData(this, width, height);
                        this.tileBitmapHorz(this.var_5419, destGripLBitmap);
                        barGripL.disposesBitmap = true;
                        barGripL.bitmap = destGripLBitmap;
                    };
                    state = 3;
                    width = barGripR.width;
                    height = barGripR.height;
                    if (((width > 0) && (height > 0)))
                    {
                        destGripRBitmap = new TrackedBitmapData(this, width, height);
                        this.tileBitmapHorz(this.var_5419, destGripRBitmap);
                        barGripR.disposesBitmap = true;
                        barGripR.bitmap = destGripRBitmap;
                    };
                }
                catch(e:Error)
                {
                    throw (new Error(((((((e.message + " width:") + width) + " height:") + height) + " state:") + state), e.errorID));
                };
            };
            if (this.var_5416 == null)
            {
                return;
            };
            this.var_5416.bitmap = this.var_5424;
            this.var_5416.disposesBitmap = false;
        }

        private function tileBitmapHorz(param1:BitmapData, param2:BitmapData):void
        {
            var _loc3_:int = int((param2.width / param1.width));
            var _loc4_:Point = new Point();
            var _loc5_:int;
            while (_loc5_ < (_loc3_ + 1))
            {
                _loc4_.x = (_loc5_ * param1.width);
                param2.copyPixels(param1, param1.rect, _loc4_);
                _loc5_++;
            };
        }

        private function onPulldownMouseDown(param1:WindowMouseEvent):void
        {
            if (this._widget != null)
            {
                this._widget.onPulldownMouseDown(param1);
            };
        }

        private function onCloseButtonClicked(param1:WindowMouseEvent):void
        {
            if (this._widget != null)
            {
                this._widget.onPulldownCloseButtonClicked(param1);
            };
        }

        private function onCloseButtonMouseOver(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_5422;
            };
        }

        private function onCloseButtonMouseOut(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_5421;
            };
        }

        private function onCloseButtonMouseDown(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_5423;
            };
        }

        private function onCloseButtonMouseUp(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_5422;
            };
        }


    }
}