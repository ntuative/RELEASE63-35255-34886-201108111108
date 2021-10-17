package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetShowOwnRoomsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenInventoryMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenCatalogMessage;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class MeMenuMainView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;
        private var var_5362:Dictionary;


        public function init(param1:MeMenuWidget, param2:String):void
        {
            this.var_5362 = new Dictionary();
            this.var_5362["rooms_icon"] = ["gohome_white", "gohome_color"];
            this.var_5362["dance_icon"] = ["dance_white", "dance_color"];
            this.var_5362["clothes_icon"] = ["clothes_white", "clothes_color"];
            this.var_5362["effects_icon"] = ["effects_white", "effects_color"];
            this.var_5362["badges_icon"] = ["badges_white", "badges_color"];
            this.var_5362["wave_icon"] = ["wave_white", "wave_color"];
            this.var_5362["hc_icon"] = ["_white", "_color"];
            this.var_5362["settings_icon"] = ["settings_white", "settings_color"];
            this.var_5362["credits_icon"] = ["credits_white", "credits_color"];
            this.var_5362["news_icon"] = ["news_white", "news_color"];
            this._widget = param1;
            this.createWindow(param2);
        }

        public function dispose():void
        {
            this._widget = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
        }

        public function get window():IWindowContainer
        {
            return (this._window);
        }

        public function setIconAssets(param1:String, param2:String, param3:String=null, param4:String=null):void
        {
            if (this.var_5362[param1] == null)
            {
                return;
            };
            if (param3 != null)
            {
                this.var_5362[param1][0] = param3;
            };
            if (param4 != null)
            {
                this.var_5362[param1][1] = param4;
            };
            this.setElementImage(param1, param3);
        }

        private function createWindow(param1:String):void
        {
            var _loc4_:String;
            var _loc5_:IWindow;
            var _loc6_:int;
            var _loc7_:Array;
            var _loc8_:String;
            var _loc9_:Number;
            var _loc10_:String;
            if (this._widget == null)
            {
                return;
            };
            var _loc2_:String = "memenu_main";
            if (((this._widget.config.getBoolean("menu.own_avatar.enabled", false)) && (this._widget.config.getBoolean("simple.memenu.enabled", false))))
            {
                _loc2_ = (_loc2_ + "_simple");
            };
            var _loc3_:XmlAsset = (this._widget.assets.getAssetByName(_loc2_) as XmlAsset);
            Logger.log(("Show window: " + _loc3_));
            this._window = (this._widget.windowManager.buildFromXML((_loc3_.content as XML)) as IWindowContainer);
            if (this._window == null)
            {
                throw (new Error("Failed to construct me menu main window from XML!"));
            };
            this._window.name = param1;
            for (_loc4_ in this.var_5362)
            {
                _loc7_ = this.var_5362[_loc4_];
                if (!((_loc7_ == null) || (_loc7_.length == 0)))
                {
                    _loc8_ = _loc7_[0];
                    _loc9_ = 1;
                    switch (_loc4_)
                    {
                        case "dance_icon":
                        case "wave_icon":
                            if (this._widget.hasEffectOn)
                            {
                                _loc9_ = 0.5;
                            };
                            break;
                        case "effects_icon":
                            if (this._widget.isDancing)
                            {
                                _loc9_ = 0.5;
                            };
                            break;
                        case "hc_icon":
                            _loc8_ = (this.getClubAssetNameBase() + _loc8_);
                            if (!this._widget.isHabboClubActive)
                            {
                                this.setElementText("hc_text", this._widget.localizations.getKey("widget.memenu.hc.join"));
                            }
                            else
                            {
                                if (this._widget.habboClubLevel == HabboClubLevelEnum.var_114)
                                {
                                    _loc10_ = "widget.memenu.vip";
                                }
                                else
                                {
                                    _loc10_ = "widget.memenu.hc";
                                };
                                if (this._widget.habboClubPeriods > 0)
                                {
                                    _loc10_ = (_loc10_ + ".long");
                                };
                                this._widget.localizations.registerParameter(_loc10_, "days", String(this._widget.habboClubDays));
                                this._widget.localizations.registerParameter(_loc10_, "months", String(this._widget.habboClubPeriods));
                                this.setElementText("hc_text", this._widget.localizations.getKey(_loc10_));
                            };
                            break;
                        case "news_icon":
                            if (!this._widget.isNewsEnabled)
                            {
                                _loc9_ = 0.5;
                            };
                            break;
                    };
                    this.setElementImage(_loc4_, _loc8_, _loc9_);
                };
            };
            _loc6_ = 0;
            while (_loc6_ < this._window.numChildren)
            {
                _loc5_ = this._window.getChildAt(_loc6_);
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOverOrOut);
                _loc5_.addEventListener(WindowMouseEvent.var_624, this.onMouseOverOrOut);
                _loc6_++;
            };
        }

        private function getClubAssetNameBase():String
        {
            switch (this._widget.habboClubLevel)
            {
                case HabboClubLevelEnum.var_255:
                case HabboClubLevelEnum.var_256:
                    return ("club");
                case HabboClubLevelEnum.var_114:
                    return ("vip");
            };
            return (null);
        }

        private function setElementImage(param1:String, param2:String, param3:Number=1):void
        {
            var _loc4_:IBitmapWrapperWindow = (this._window.findChildByName(param1) as IBitmapWrapperWindow);
            var _loc5_:BitmapDataAsset = (this._widget.assets.getAssetByName(param2) as BitmapDataAsset);
            if (_loc4_ == null)
            {
                Logger.log(("Could not find element: " + param1));
                return;
            };
            if (((_loc5_ == null) || (_loc5_.content == null)))
            {
                Logger.log(("Could not find asset: " + param2));
                return;
            };
            var _loc6_:BitmapData = (_loc5_.content as BitmapData);
            _loc4_.bitmap = new BitmapData(_loc4_.width, _loc4_.height, true, 0);
            var _loc7_:int = int(((_loc4_.width - _loc6_.width) / 2));
            var _loc8_:int = int(((_loc4_.height - _loc6_.height) / 2));
            _loc4_.bitmap.copyPixels(_loc6_, _loc6_.rect, new Point(_loc7_, _loc8_));
            _loc4_.blend = param3;
        }

        private function setElementText(param1:String, param2:String):void
        {
            var _loc3_:ITextWindow = (this._window.findChildByName(param1) as ITextWindow);
            if (_loc3_ != null)
            {
                _loc3_.text = param2;
            };
        }

        private function onButtonClicked(param1:WindowMouseEvent):void
        {
            var _loc4_:Boolean;
            var _loc5_:String;
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            switch (_loc3_)
            {
                case "dance":
                    if (this._widget.hasEffectOn)
                    {
                        return;
                    };
                    this._widget.changeView(MeMenuWidget.var_1687);
                    break;
                case "wave":
                    if (this._widget.hasEffectOn)
                    {
                        return;
                    };
                    if (this._widget.isDancing)
                    {
                        this._widget.messageListener.processWidgetMessage(new RoomWidgetDanceMessage(RoomWidgetDanceMessage.var_2374));
                        this._widget.isDancing = false;
                    };
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetWaveMessage());
                    this._widget.hide();
                    break;
                case "effects":
                    if (this._widget.isDancing)
                    {
                        return;
                    };
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.var_2275));
                    this._widget.hide();
                    break;
                case "rooms":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetShowOwnRoomsMessage());
                    this._widget.hide();
                    break;
                case "badges":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetOpenInventoryMessage(RoomWidgetOpenInventoryMessage.var_2278));
                    this._widget.hide();
                    break;
                case "clothes":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetAvatarEditorMessage(RoomWidgetAvatarEditorMessage.var_2266));
                    this._widget.hide();
                    break;
                case "hc":
                    this._widget.messageListener.processWidgetMessage(new RoomWidgetOpenCatalogMessage(RoomWidgetOpenCatalogMessage.var_2276));
                    this._widget.hide();
                    break;
                case "settings":
                    this._widget.changeView(MeMenuWidget.var_1688);
                    break;
                case "news":
                    if (((ExternalInterface.available) && (this._widget.isNewsEnabled)))
                    {
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
                        this._widget.hide();
                    };
                    break;
                case "credits":
                    _loc4_ = (this._widget.config.getKey("client.credits.embed.enabled", "false") == "true");
                    if (((ExternalInterface.available) && (_loc4_)))
                    {
                        ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
                    }
                    else
                    {
                        _loc5_ = this._widget.config.getKey("link.format.credits", "/credits");
                        HabboWebTools.navigateToURL(_loc5_, "habboMain");
                        this._widget.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.onAlertClicked);
                    };
                    this._widget.hide();
                    break;
                default:
                    Logger.log(("Me Menu Main View: unknown button: " + _loc3_));
            };
            HabboTracking.getInstance().trackEventLog("MeMenu", "click", _loc3_);
        }

        private function onAlertClicked(param1:IAlertDialog, param2:WindowEvent):void
        {
            param1.dispose();
        }

        private function onMouseOverOrOut(param1:WindowMouseEvent):void
        {
            var _loc5_:Array;
            var _loc6_:String;
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            var _loc4_:* = (_loc3_ + "_icon");
            var _loc7_:String = "";
            var _loc8_:int = ((param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER) ? 1 : 0);
            switch (_loc3_)
            {
                case "dance":
                    if (this._widget.hasEffectOn)
                    {
                        return;
                    };
                    break;
                case "news":
                    if (!this._widget.isNewsEnabled)
                    {
                        return;
                    };
                    break;
                case "wave":
                    if (this._widget.hasEffectOn)
                    {
                        return;
                    };
                    break;
                case "effects":
                    if (this._widget.isDancing)
                    {
                        return;
                    };
                    break;
                case "hc":
                    _loc7_ = this.getClubAssetNameBase();
                    break;
            };
            _loc4_ = (_loc3_ + "_icon");
            _loc5_ = this.var_5362[_loc4_];
            if (_loc5_ != null)
            {
                _loc6_ = (_loc7_ + _loc5_[_loc8_]);
                this.setElementImage(_loc4_, _loc6_);
            };
        }


    }
}