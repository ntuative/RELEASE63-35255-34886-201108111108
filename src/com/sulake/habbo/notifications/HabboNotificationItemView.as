package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.display.BitmapData;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HabboNotificationItemView implements IUpdateReceiver 
    {

        public static const var_559:int = 70;
        public static const var_1859:int = 5;
        private static const var_1860:int = 0;
        private static const var_1861:int = 1;
        private static const var_1862:int = 2;
        private static const var_1863:int = 3;

        private var _window:IWindow;
        private var var_3808:HabboNotificationItem;
        private var var_4381:Boolean = false;
        private var var_4382:Map;
        private var var_4383:Map;
        private var var_4384:uint;
        private var var_4385:uint;
        private var var_4386:uint;
        private var var_4387:int;
        private var var_1213:Number;
        private var var_4388:int;
        private var var_4389:int;
        private var _state:int;

        public function HabboNotificationItemView(param1:IAsset, param2:IHabboWindowManager, param3:Map, param4:Map, param5:HabboNotificationItem)
        {
            this.var_4382 = param3;
            this.var_4383 = param4;
            var _loc6_:XmlAsset = (param1 as XmlAsset);
            if (_loc6_ == null)
            {
                return;
            };
            this._window = param2.buildFromXML((_loc6_.content as XML), 1);
            this._window.tags.push("notificationview");
            this._window.context.getDesktopWindow().addEventListener(WindowEvent.var_589, this.onRoomViewResized);
            this._window.procedure = this.onWindowEvent;
            this._window.blend = 0;
            this._window.visible = false;
            var _loc7_:ITextWindow = (IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow);
            if (_loc7_ != null)
            {
                this.var_4388 = (this._window.height - _loc7_.rectangle.bottom);
            }
            else
            {
                this.var_4388 = 15;
            };
            this.var_4389 = this._window.height;
            this.var_4387 = 4;
            this.var_1213 = 0;
            this._state = var_1860;
            this.showItem(param5);
        }

        public function get disposed():Boolean
        {
            return (this._window == null);
        }

        public function get ready():Boolean
        {
            return (this._state == var_1860);
        }

        public function get verticalPosition():int
        {
            return (this.var_4387);
        }

        private function showItem(param1:HabboNotificationItem):void
        {
            if (param1 == null)
            {
                return;
            };
            var _loc2_:String = param1.content;
            this.setNotificationText(_loc2_);
            var _loc3_:BitmapData = param1.style.icon;
            this.setNotificationIcon(_loc3_);
            this.var_3808 = param1;
            this.reposition();
            this.startFadeIn();
        }

        public function replaceIcon(param1:BadgeImageReadyEvent):void
        {
            if (param1.badgeId != this.var_3808.style.iconSrc)
            {
                return;
            };
            if (param1.badgeImage != null)
            {
                this.setNotificationIcon(param1.badgeImage);
            };
        }

        public function update(param1:uint):void
        {
            var _loc2_:Number;
            var _loc3_:Number;
            switch (this._state)
            {
                case var_1860:
                    return;
                case var_1861:
                    this.var_4384 = (this.var_4384 + param1);
                    _loc2_ = (Number(this.var_4384) / Number(this.var_4383["time_fade_in"]));
                    if (this.var_4384 > int(this.var_4383["time_fade_in"]))
                    {
                        this.startDisplay();
                    };
                    this.adjustBlend(_loc2_);
                    return;
                case var_1862:
                    this.var_4386 = (this.var_4386 + param1);
                    if (((this.var_4386 > int(this.var_4383["time_display"])) && (!(this.var_4381))))
                    {
                        this.startFadeOut();
                    };
                    return;
                case var_1863:
                    this.var_4385 = (this.var_4385 + param1);
                    _loc3_ = (1 - (Number(this.var_4385) / Number(this.var_4383["time_fade_out"])));
                    this.adjustBlend(_loc3_);
                    if (this.var_4385 > int(this.var_4383["time_fade_in"]))
                    {
                        this.startIdling();
                    };
                    return;
            };
        }

        public function dispose():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_3808 != null)
            {
                this.var_3808.dispose();
                this.var_3808 = null;
            };
        }

        private function setNotificationText(param1:String):void
        {
            var _loc2_:ITextWindow = (IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow);
            if (((_loc2_ == null) || (param1 == null)))
            {
                return;
            };
            this._window.height = 0;
            _loc2_.text = param1;
            _loc2_.height = (_loc2_.textHeight + this.var_4388);
            if (this._window.height < this.var_4389)
            {
                this._window.height = this.var_4389;
            };
        }

        private function setNotificationIcon(param1:BitmapData):void
        {
            var _loc3_:BitmapData;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc2_:IBitmapWrapperWindow = (IWindowContainer(this._window).findChildByTag("notification_icon") as IBitmapWrapperWindow);
            if (_loc2_ == null)
            {
                return;
            };
            if (param1 == null)
            {
                _loc2_.bitmap = null;
                return;
            };
            if (((param1.width < _loc2_.width) && (param1.height < _loc2_.height)))
            {
                _loc3_ = new BitmapData(_loc2_.width, _loc2_.height, true, 0);
                _loc5_ = int(((_loc2_.width - param1.width) / 2));
                _loc6_ = int(((_loc2_.height - param1.height) / 2));
                _loc3_.copyPixels(param1, param1.rect, new Point(_loc5_, _loc6_));
            }
            else
            {
                if (param1.width < param1.height)
                {
                    _loc3_ = new BitmapData(param1.height, param1.height, true, 0);
                    _loc4_ = int(((param1.height - param1.width) / 2));
                    _loc3_.copyPixels(param1, param1.rect, new Point(_loc4_, 0));
                }
                else
                {
                    if (param1.width > param1.height)
                    {
                        _loc3_ = new BitmapData(param1.width, param1.width, true, 0);
                        _loc4_ = int(((param1.width - param1.height) / 2));
                        _loc3_.copyPixels(param1, param1.rect, new Point(0, _loc4_));
                    }
                    else
                    {
                        _loc3_ = new BitmapData(param1.width, param1.height);
                        _loc3_.copyPixels(param1, param1.rect, new Point(0, 0));
                    };
                };
            };
            _loc2_.bitmap = _loc3_;
        }

        private function startFadeIn():void
        {
            this.var_4384 = 0;
            this._state = var_1861;
            this._window.visible = true;
        }

        private function startFadeOut():void
        {
            this.var_4385 = 0;
            this._state = var_1863;
        }

        private function startDisplay():void
        {
            this.var_4386 = 0;
            this._state = var_1862;
        }

        private function startIdling():void
        {
            this._state = var_1860;
            this._window.visible = false;
        }

        public function reposition(param1:int=-1):void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IDesktopWindow = this._window.context.getDesktopWindow();
            if (_loc2_ == null)
            {
                return;
            };
            if (param1 != -1)
            {
                this.var_4387 = param1;
            };
            this._window.x = ((_loc2_.width - this._window.width) - var_1859);
            this._window.y = this.var_4387;
        }

        public function onWindowEvent(param1:WindowEvent, param2:IWindow):void
        {
            if (param1 == null)
            {
                return;
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                this.var_4381 = true;
                Logger.log("notifications - hover on");
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_624)
                {
                    this.var_4381 = false;
                    Logger.log("notifications - hover off");
                }
                else
                {
                    if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                    {
                        if (this.var_3808 != null)
                        {
                            this.var_3808.ExecuteUiLinks();
                        };
                    };
                };
            };
        }

        private function onRoomViewResized(param1:WindowEvent):void
        {
            this.reposition();
        }

        private function adjustBlend(param1:Number):void
        {
            this.var_1213 = param1;
            if (this.var_1213 > 1)
            {
                this.var_1213 = 1;
            };
            if (this.var_1213 < 0)
            {
                this.var_1213 = 0;
            };
            this._window.blend = this.var_1213;
        }


    }
}