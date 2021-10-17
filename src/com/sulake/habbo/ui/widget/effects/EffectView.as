package com.sulake.habbo.ui.widget.effects
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class EffectView 
    {

        private const var_5233:int = 1000;

        private var _widget:EffectsWidget;
        private var _window:IWindowContainer;
        private var var_4494:IWidgetAvatarEffect;
        private var var_5234:IWindow;
        private var var_2803:Number;
        private var var_5235:ITextWindow;
        private var var_2486:Timer;
        private var var_5236:IWindow;

        public function EffectView(param1:EffectsWidget, param2:IWidgetAvatarEffect)
        {
            this.var_4494 = param2;
            this._widget = param1;
            this.var_2486 = new Timer(this.var_5233);
            this.var_2486.addEventListener(TimerEvent.TIMER, this.onUpdate);
            this.update();
        }

        public function get effect():IWidgetAvatarEffect
        {
            return (this.var_4494);
        }

        public function dispose():void
        {
            if (this.var_2486 != null)
            {
                this.var_2486.stop();
                this.var_2486.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this.var_2486 = null;
            };
            this._widget = null;
            this.var_4494 = null;
            this.var_5234 = null;
            this.var_5235 = null;
            this.var_5236 = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        private function onUpdate(param1:Event=null):void
        {
            var _loc2_:Number;
            if (this.var_5234 == null)
            {
                this.var_2486.stop();
                return;
            };
            if (this.var_4494.isActive)
            {
                _loc2_ = (this.var_4494.secondsLeft / Number(this.var_4494.duration));
                this.var_5234.width = (_loc2_ * this.var_2803);
            }
            else
            {
                this.var_5234.width = 0;
                this.var_2486.stop();
            };
            this.setTimeLeft();
        }

        private function setTimeLeft():void
        {
            var _loc1_:String;
            var _loc2_:int;
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:String;
            if (this.var_5235 == null)
            {
                this.var_5235 = (this._window.findChildByName("time_left") as ITextWindow);
                if (this.var_5235 == null)
                {
                    return;
                };
            };
            if (!this.var_4494.isActive)
            {
                this.var_5235.caption = "${widgets.memenu.effects.activate}";
                return;
            };
            if (this.var_4494.secondsLeft > ((60 * 60) * 24))
            {
                this.var_5235.caption = "${widgets.memenu.effects.active.daysleft}";
                _loc1_ = this.var_5235.text;
                _loc2_ = int(Math.floor((this.var_4494.secondsLeft / ((60 * 60) * 24))));
                _loc1_ = _loc1_.replace("%days_left%", _loc2_);
            }
            else
            {
                this.var_5235.caption = "${widgets.memenu.effects.active.timeleft}";
                _loc1_ = this.var_5235.text;
                _loc3_ = this.var_4494.secondsLeft;
                _loc4_ = int(Math.floor((_loc3_ / (60 * 60))));
                _loc5_ = int((Math.floor((_loc3_ / 60)) % 60));
                _loc6_ = (_loc3_ % 60);
                _loc7_ = ((_loc4_ < 10) ? "0" : "");
                _loc8_ = ((_loc5_ < 10) ? "0" : "");
                _loc9_ = ((_loc6_ < 10) ? "0" : "");
                if (_loc4_ > 0)
                {
                    _loc1_ = _loc1_.replace("%time_left%", (((((((_loc7_ + _loc4_) + ":") + _loc8_) + _loc5_) + ":") + _loc9_) + _loc6_));
                }
                else
                {
                    _loc1_ = _loc1_.replace("%time_left%", ((((_loc8_ + _loc5_) + ":") + _loc9_) + _loc6_));
                };
            };
            this.var_5235.text = _loc1_;
        }

        public function update():void
        {
            var _loc1_:XmlAsset;
            var _loc7_:IWindow;
            var _loc8_:IButtonWindow;
            if (!this._window)
            {
                this._window = (this._widget.windowManager.createWindow("", "", HabboWindowType.var_218, HabboWindowStyle.var_613, HabboWindowParam.var_159) as IWindowContainer);
            };
            while (this._window.numChildren > 0)
            {
                _loc7_ = this._window.removeChildAt(0);
                _loc7_.dispose();
            };
            this.var_5234 = null;
            this.var_5236 = null;
            this.var_5235 = null;
            var _loc2_:String = "";
            if (this.var_4494.isInUse)
            {
                _loc2_ = "memenu_effect_selected";
            }
            else
            {
                if (this.var_4494.isActive)
                {
                    _loc2_ = "memenu_effect_unselected";
                }
                else
                {
                    _loc2_ = "memenu_effect_inactive";
                };
            };
            _loc1_ = (this._widget.assets.getAssetByName(_loc2_) as XmlAsset);
            var _loc3_:IWindowContainer = (this._widget.windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            this._window.addChild(_loc3_);
            var _loc4_:ITextWindow = (this._window.findChildByName("effect_name") as ITextWindow);
            if (_loc4_ != null)
            {
                _loc4_.caption = ((("$" + "{fx_") + this.var_4494.type) + "}");
            };
            var _loc5_:ITextWindow = (this._window.findChildByName("effect_amount") as ITextWindow);
            if (_loc5_ != null)
            {
                _loc5_.caption = (this.var_4494.effectsInInventory + "");
            };
            var _loc6_:IWindowContainer = (this._window.findChildByName("effect_amount_bg1") as IWindowContainer);
            if (this.var_4494.effectsInInventory < 2)
            {
                if (_loc6_ != null)
                {
                    _loc6_.visible = false;
                };
            };
            if (_loc2_ == "memenu_effect_inactive")
            {
                _loc8_ = (this._window.findChildByName("activate_effect") as IButtonWindow);
                if (_loc8_ != null)
                {
                    _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                };
            }
            else
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                if (this.var_4494.isActive)
                {
                    _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseEvent);
                    _loc3_.addEventListener(WindowMouseEvent.var_624, this.onMouseEvent);
                };
                if (this.var_4494.isInUse)
                {
                    this.setElementImage("effect_hilite", "memenu_fx_pause");
                }
                else
                {
                    this.setElementImage("effect_hilite", "memenu_fx_play");
                };
                this.var_5236 = this._window.findChildByName("effect_hilite");
                this.var_5236.visible = false;
            };
            this.setTimeLeft();
            this.var_5234 = this._window.findChildByName("loader_bar");
            if (this.var_5234 != null)
            {
                this.var_2803 = this.var_5234.width;
                this.var_2486.start();
                this.onUpdate();
            };
            if (this.var_4494.icon)
            {
                this.setElementBitmap("effect_icon", this.var_4494.icon);
            };
            this._window.rectangle = _loc3_.rectangle;
        }

        private function setElementBitmap(param1:String, param2:BitmapData):void
        {
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName(param1) as IBitmapWrapperWindow);
            if (_loc3_ != null)
            {
                if (_loc3_.bitmap)
                {
                    _loc3_.bitmap.dispose();
                };
                _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
                _loc3_.bitmap.copyPixels(param2, param2.rect, new Point(0, 0));
            }
            else
            {
                Logger.log(("Could not find element: " + param1));
            };
        }

        private function onMouseEvent(param1:WindowMouseEvent):void
        {
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    if (this.var_5236 != null)
                    {
                        this.var_5236.visible = true;
                    };
                    return;
                case WindowMouseEvent.var_624:
                    if (this.var_5236 != null)
                    {
                        this.var_5236.visible = false;
                    };
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    this._widget.selectEffect(this.var_4494.type, this.var_4494.isInUse);
                    return;
            };
        }

        private function setElementImage(param1:String, param2:String):void
        {
            var _loc3_:BitmapDataAsset = (this._widget.assets.getAssetByName(param2) as BitmapDataAsset);
            var _loc4_:BitmapData = (_loc3_.content as BitmapData);
            this.setElementBitmap(param1, _loc4_);
        }


    }
}