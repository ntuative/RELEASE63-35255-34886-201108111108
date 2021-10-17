package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.FixedSizeStack;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;

    public class AvatarInfoView implements IDisposable 
    {

        protected static const var_2409:uint = 4281149991;
        protected static const var_2398:uint = 4282950861;
        protected static const var_2414:uint = 0xFF993300;
        protected static const var_2410:uint = 0xFFFFFF;
        protected static const var_2408:uint = 9552639;
        protected static const var_2403:uint = 0xFFFFFF;
        protected static const var_2404:uint = 5789011;
        protected static const var_2405:uint = 13947341;
        protected static const var_2406:uint = 5789011;
        private static const var_2396:int = 25;
        private static const var_2397:int = 3;
        protected static var var_2402:Boolean = false;

        protected var _window:IWindowContainer;
        protected var var_5182:IWindowContainer;
        protected var var_5183:IWindowContainer;
        private var var_5184:Boolean;
        protected var _widget:AvatarInfoWidget;
        protected var _userId:int;
        protected var _userName:String;
        protected var var_3545:int;
        protected var var_5185:Boolean;
        protected var var_3804:int;
        protected var var_5186:Boolean;
        protected var var_5187:FixedSizeStack = new FixedSizeStack(var_2396);
        protected var var_5188:int = -1000000;
        protected var _disposed:Boolean;
        protected var var_5189:Timer;
        protected var var_5190:int = 3000;
        protected var var_5191:Boolean;
        protected var var_5192:Boolean;
        protected var var_1213:Number;
        protected var var_4665:int;
        protected var var_5193:int = 500;
        protected var var_5194:Boolean;

        public function AvatarInfoView(param1:AvatarInfoWidget)
        {
            this._widget = param1;
            this.var_5194 = true;
            this.var_5191 = false;
            this.var_5192 = false;
        }

        public static function setup(param1:AvatarInfoView, param2:int, param3:String, param4:int, param5:int, param6:Boolean=false):void
        {
            param1._userId = param2;
            param1._userName = param3;
            param1.var_3545 = param5;
            param1.var_3804 = param4;
            param1.var_5185 = param6;
            param1.var_5191 = false;
            param1.var_5193 = 500;
            param1.var_5192 = false;
            param1.var_1213 = 1;
            if (param1.var_5194)
            {
                if (!param1.var_5189)
                {
                    param1.var_5189 = new Timer(param1.var_5190, 1);
                    param1.var_5189.addEventListener(TimerEvent.TIMER_COMPLETE, param1.onTimerComplete);
                };
                param1.var_5189.reset();
                param1.var_5189.start();
            };
            param1.updateWindow();
        }


        public function get userId():int
        {
            return (this._userId);
        }

        public function get userType():int
        {
            return (this.var_3545);
        }

        public function get roomIndex():int
        {
            return (this.var_3804);
        }

        public function get userName():String
        {
            return (this._userName);
        }

        public function get allowNameChange():Boolean
        {
            return (this.var_5185);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            this._widget = null;
            this.var_5183 = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_5182)
            {
                this.var_5182.dispose();
                this.var_5182 = null;
            };
            if (this.var_5189)
            {
                this.var_5189.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
                this.var_5189.reset();
                this.var_5189 = null;
            };
            this._disposed = true;
        }

        private function onTimerComplete(param1:TimerEvent):void
        {
            this.var_5192 = true;
            this.var_4665 = 0;
            this.hide(true);
        }

        protected function addMouseClickListener(param1:IWindow, param2:Function):void
        {
            if (param1 != null)
            {
                param1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, param2);
            };
        }

        protected function updateWindow():void
        {
            var _loc2_:XML;
            var _loc3_:IWindow;
            if ((((!(this._widget)) || (!(this._widget.assets))) || (!(this._widget.windowManager))))
            {
                return;
            };
            if (!this._window)
            {
                _loc2_ = (this._widget.assets.getAssetByName("avatar_info_widget").content as XML);
                this._window = (this._widget.windowManager.buildFromXML(_loc2_, 0) as IWindowContainer);
                if (!this._window)
                {
                    return;
                };
            };
            var _loc1_:IWindow = this._window.findChildByName("name");
            _loc1_.caption = this._userName;
            if (!this.var_5185)
            {
                this._window.findChildByName("change_name_container").visible = false;
                this._window.height = 39;
                this._window.width = (32 + _loc1_.width);
            }
            else
            {
                _loc3_ = this._window.findChildByName("change_name_container");
                _loc3_.visible = true;
                this._window.height = (39 + _loc3_.height);
                this.addMouseClickListener(this._window.findChildByName("change_name_container"), this.clickHandler);
            };
            this.activeView = this._window;
        }

        protected function clickHandler(param1:WindowMouseEvent):void
        {
            this._widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_2284));
            this._widget.removeView(this, false);
        }

        public function setImageAsset(param1:IBitmapWrapperWindow, param2:String):void
        {
            if ((((!(param1)) || (!(this._widget))) || (!(this._widget.assets))))
            {
                return;
            };
            var _loc3_:BitmapDataAsset = (this._widget.assets.getAssetByName(param2) as BitmapDataAsset);
            if (!_loc3_)
            {
                return;
            };
            var _loc4_:BitmapData = (_loc3_.content as BitmapData);
            if (!_loc4_)
            {
                return;
            };
            if (param1.bitmap)
            {
                param1.bitmap.fillRect(param1.bitmap.rect, 0);
            }
            else
            {
                param1.bitmap = new BitmapData(param1.width, param1.height, true, 0);
            };
            param1.bitmap.draw(_loc4_);
        }

        public function show():void
        {
            if (this.var_5183 != null)
            {
                this._widget.windowManager.getDesktop(0).addChild(this.var_5183);
                this.var_5183.visible = true;
                this.var_5183.activate();
            };
        }

        public function hide(param1:Boolean):void
        {
            if (this.var_5183 != null)
            {
                if (((!(this.var_5191)) && (param1)))
                {
                    this.var_5191 = true;
                    this.var_5189.start();
                }
                else
                {
                    this.var_5183.visible = false;
                    this.var_5183.parent = null;
                };
            };
        }

        public function update(param1:Rectangle, param2:Point, param3:uint):void
        {
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:int;
            var _loc7_:int;
            if (!param1)
            {
                return;
            };
            if (!this.var_5183)
            {
                this.updateWindow();
            };
            if (this.var_5192)
            {
                this.var_4665 = (this.var_4665 + param3);
                this.var_1213 = (1 - (this.var_4665 / Number(this.var_5193)));
            }
            else
            {
                this.var_1213 = 1;
            };
            if (this.var_1213 <= 0)
            {
                this._widget.removeView(this, false);
                return;
            };
            if (((!(this.var_5186)) || (this.var_5184)))
            {
                _loc4_ = -(this.var_5183.height);
                if (((this.var_3545 == RoomObjectTypeEnum.var_1406) || (this.var_3545 == RoomObjectTypeEnum.var_1712)))
                {
                    _loc4_ = (_loc4_ + ((param1.height > 50) ? 25 : 0));
                }
                else
                {
                    _loc4_ = (_loc4_ - 4);
                };
                _loc5_ = (param2.y - param1.top);
                this.var_5187.addValue(_loc5_);
                _loc6_ = this.var_5187.getMax();
                if (_loc6_ < (this.var_5188 - var_2397))
                {
                    _loc6_ = (this.var_5188 - var_2397);
                };
                _loc7_ = (param2.y - _loc6_);
                this.var_5188 = _loc6_;
                this.var_5183.x = (param2.x - (this.var_5183.width / 2));
                this.var_5183.y = (_loc7_ + _loc4_);
                this.var_5184 = false;
            };
            this.var_5183.blend = this.var_1213;
            this.show();
        }

        protected function onMouseHoverEvent(param1:WindowMouseEvent):void
        {
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                this.var_5186 = true;
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_624)
                {
                    if (!param1.window.hitTestGlobalPoint(new Point(param1.stageX, param1.stageY)))
                    {
                        this.var_5186 = false;
                    };
                };
            };
        }

        protected function setMinimized(param1:Boolean):void
        {
            var_2402 = param1;
            this.var_5184 = true;
            this.updateWindow();
        }

        protected function getMinimizedView():IWindowContainer
        {
            var _loc1_:XML;
            if (!this.var_5182)
            {
                _loc1_ = (XmlAsset(this._widget.assets.getAssetByName("minimized_menu")).content as XML);
                this.var_5182 = (this._widget.windowManager.buildFromXML(_loc1_, 0) as IWindowContainer);
                this.var_5182.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMaximize);
                this.var_5182.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMinimizeHover);
                this.var_5182.findChildByName("minimize").addEventListener(WindowMouseEvent.var_624, this.onMinimizeHover);
                this.var_5182.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseHoverEvent);
                this.var_5182.addEventListener(WindowMouseEvent.var_624, this.onMouseHoverEvent);
            };
            return (this.var_5182);
        }

        private function onMaximize(param1:WindowMouseEvent):void
        {
            this.setMinimized(false);
        }

        protected function set activeView(param1:IWindowContainer):void
        {
            if (!param1)
            {
                return;
            };
            if (this.var_5183)
            {
                this.var_5183.parent = null;
            };
            this.var_5183 = param1;
        }

        protected function onMinimize(param1:WindowMouseEvent):void
        {
            this.setMinimized(true);
        }

        protected function onMinimizeHover(param1:WindowMouseEvent):void
        {
            var _loc3_:IWindow;
            var _loc2_:IWindowContainer = (param1.window as IWindowContainer);
            if (_loc2_)
            {
                _loc3_ = _loc2_.findChildByName("icon");
                if (_loc3_)
                {
                    if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                    {
                        _loc3_.color = var_2398;
                    }
                    else
                    {
                        _loc3_.color = 0xFFFFFF;
                    };
                };
            };
        }


    }
}