package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OwnAvatarMenuView extends AvatarInfoView 
    {

        private static const var_2401:int = 0;
        private static const var_2399:int = 1;
        private static const var_2400:int = 2;
        private static const var_2407:int = 8;

        private var _data:AvatarInfoData;
        private var var_3048:int;
        private var _buttons:IItemListWindow;

        public function OwnAvatarMenuView(param1:AvatarInfoWidget)
        {
            super(param1);
            var_5194 = false;
        }

        public static function setup(param1:OwnAvatarMenuView, param2:int, param3:String, param4:int, param5:int, param6:AvatarInfoData):void
        {
            param1._data = param6;
            if ((((param1._widget.isDancing) && (param1._widget.hasClub)) && (!(param1._widget.hasEffectOn))))
            {
                param1.var_3048 = var_2399;
            }
            else
            {
                if (((param6.allowNameChange) && (param1._widget.useMinimizedOwnAvatarMenu)))
                {
                    param1.var_3048 = var_2400;
                }
                else
                {
                    param1.var_3048 = var_2401;
                };
            };
            AvatarInfoView.setup(param1, param2, param3, param4, param5, false);
        }


        override public function dispose():void
        {
            this._buttons = null;
            this._data = null;
            super.dispose();
        }

        override protected function updateWindow():void
        {
            var _loc1_:XML;
            if ((((!(_widget)) || (!(_widget.assets))) || (!(_widget.windowManager))))
            {
                return;
            };
            if (var_2402)
            {
                activeView = getMinimizedView();
            }
            else
            {
                if (!_window)
                {
                    _loc1_ = (XmlAsset(_widget.assets.getAssetByName("own_avatar_menu")).content as XML);
                    _window = (_widget.windowManager.buildFromXML(_loc1_, 0) as IWindowContainer);
                    if (!_window)
                    {
                        return;
                    };
                    _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseHoverEvent);
                    _window.addEventListener(WindowMouseEvent.var_624, onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMinimize);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.var_624, onMinimizeHover);
                };
                this._buttons = (_window.findChildByName("buttons") as IItemListWindow);
                this._buttons.procedure = this.buttonEventProc;
                _window.findChildByName("name").caption = _userName;
                _window.visible = false;
                activeView = _window;
                this.updateButtons();
            };
        }

        public function updateButtons():void
        {
            if ((((!(_window)) || (!(this._data))) || (!(this._buttons))))
            {
                return;
            };
            this._buttons.autoArrangeItems = false;
            var _loc1_:int = this._buttons.numListItems;
            var _loc2_:int;
            while (_loc2_ < _loc1_)
            {
                this._buttons.getListItemAt(_loc2_).visible = false;
                _loc2_++;
            };
            switch (this.var_3048)
            {
                case var_2401:
                    this.showButton("change_name", this._data.allowNameChange);
                    this.showButton("change_looks");
                    this.showButton("dance_menu", _widget.hasClub, (!(_widget.hasEffectOn)));
                    this.showButton("dance", ((!(_widget.hasClub)) && (!(_widget.isDancing))), (!(_widget.hasEffectOn)));
                    this.showButton("dance_stop", ((!(_widget.hasClub)) && (_widget.isDancing)));
                    this.showButton("wave", true, (!(_widget.hasEffectOn)));
                    this.showButton("effects", true);
                    break;
                case var_2399:
                    this.showButton("dance_stop", true, _widget.isDancing);
                    this.showButton("dance_1");
                    this.showButton("dance_2");
                    this.showButton("dance_3");
                    this.showButton("dance_4");
                    this.showButton("back");
                    break;
                case var_2400:
                    this.showButton("change_name");
                    this.showButton("more");
                    break;
            };
            this._buttons.autoArrangeItems = true;
            this._buttons.visible = true;
        }

        private function showButton(param1:String, param2:Boolean=true, param3:Boolean=true):void
        {
            if (!this._buttons)
            {
                return;
            };
            var _loc4_:IWindowContainer = (this._buttons.getListItemByName(param1) as IWindowContainer);
            if (!_loc4_)
            {
                return;
            };
            _loc4_.visible = param2;
            var _loc5_:IWindowContainer = (_loc4_.getChildByName("button") as IWindowContainer);
            if (param3)
            {
                _loc5_.enable();
            }
            else
            {
                _loc5_.disable();
            };
            var _loc6_:ITextWindow = (_loc5_.getChildByName("label") as ITextWindow);
            _loc6_.textColor = ((param3) ? var_2403 : var_2404);
            var _loc7_:IIconWindow = (_loc5_.getChildByName("icon") as IIconWindow);
            if (_loc7_)
            {
                _loc7_.color = ((param3) ? var_2405 : var_2406);
                if (_loc7_.tags.indexOf("arrow_left") != -1)
                {
                    _loc7_.x = (((_loc6_.x + ((_loc6_.width - _loc6_.textWidth) / 2)) - _loc7_.width) - var_2407);
                };
                if (_loc7_.tags.indexOf("arrow_right") != -1)
                {
                    _loc7_.x = ((_loc6_.x + ((_loc6_.width + _loc6_.textWidth) / 2)) + var_2407);
                };
            };
        }

        private function buttonEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc4_:RoomWidgetMessage;
            var _loc5_:String;
            if (disposed)
            {
                return;
            };
            if (((!(_window)) || (_window.disposed)))
            {
                return;
            };
            var _loc3_:Boolean;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                if (param2.name == "button")
                {
                    _loc3_ = true;
                    switch (param2.parent.name)
                    {
                        case "change_name":
                            _loc4_ = new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.var_2284);
                            break;
                        case "change_looks":
                            _widget.openAvatarEditor();
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "clothes");
                            break;
                        case "wave":
                            _loc4_ = new RoomWidgetWaveMessage();
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "wave");
                            break;
                        case "dance_menu":
                            _loc3_ = false;
                            this.changeMode(var_2399);
                            break;
                        case "dance":
                            _loc4_ = new RoomWidgetDanceMessage(1);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "dance_stop":
                            _loc4_ = new RoomWidgetDanceMessage(0);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_stop");
                            break;
                        case "dance_1":
                        case "dance_2":
                        case "dance_3":
                        case "dance_4":
                            _loc4_ = new RoomWidgetDanceMessage(parseInt(param2.parent.name.charAt((param2.parent.name.length - 1))));
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "effects":
                            _loc4_ = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_2275);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "effects");
                            break;
                        case "back":
                            _loc3_ = false;
                            this.changeMode(var_2401);
                            break;
                        case "more":
                            _loc3_ = false;
                            _widget.useMinimizedOwnAvatarMenu = false;
                            this.changeMode(var_2401);
                            break;
                    };
                };
                if (_loc4_)
                {
                    _widget.messageListener.processWidgetMessage(_loc4_);
                };
            }
            else
            {
                if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
                {
                    if (param2.name == "button")
                    {
                        param2.color = var_2398;
                    }
                    else
                    {
                        if (param2.tags.indexOf("link") > -1)
                        {
                            if (param2.tags.indexOf("actions") > -1)
                            {
                                ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = var_2408;
                            };
                        };
                    };
                }
                else
                {
                    if (param1.type == WindowMouseEvent.var_624)
                    {
                        if (param2.name == "button")
                        {
                            param2.color = var_2409;
                        }
                        else
                        {
                            if (param2.tags.indexOf("link") > -1)
                            {
                                if (param2.tags.indexOf("actions") > -1)
                                {
                                    ITextWindow(IWindowContainer(param2).getChildAt(0)).textColor = var_2410;
                                };
                            };
                        };
                    };
                };
            };
            if (_loc3_)
            {
                _widget.removeView(this, false);
            };
        }

        private function changeMode(param1:int):void
        {
            this.var_3048 = param1;
            this.updateButtons();
        }


    }
}