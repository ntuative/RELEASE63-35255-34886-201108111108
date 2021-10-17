package com.sulake.habbo.ui.widget.furniture.credit
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.events.WindowEvent;

    public class CreditFurniWidget extends RoomWidgetBase 
    {

        private static const var_1612:Number = 100;
        private static const var_1613:Number = 100;

        private var _window:IWindowContainer;
        private var var_5281:int = -1;
        private var var_5282:Number;

        public function CreditFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary, param4:IHabboLocalizationManager)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose():void
        {
            this.hideInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetCreditFurniUpdateEvent.var_1625, this.onObjectUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetCreditFurniUpdateEvent.var_1625, this.onObjectUpdate);
        }

        private function onObjectUpdate(param1:RoomWidgetCreditFurniUpdateEvent):void
        {
            this.hideInterface();
            this.var_5281 = param1.objectId;
            this.var_5282 = param1.creditValue;
            this.showInterface();
        }

        private function showInterface():void
        {
            var _loc3_:IWindow;
            if (this.var_5281 == -1)
            {
                return;
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            windowManager.registerLocalizationParameter("widgets.furniture.credit.redeem.value", "value", String(this.var_5282));
            var _loc1_:IAsset = assets.getAssetByName("credit_redeem");
            var _loc2_:XmlAsset = XmlAsset(_loc1_);
            if (_loc2_ == null)
            {
                return;
            };
            this._window = (windowManager.createWindow("creditfurniui_container", "", HabboWindowType.var_218, HabboWindowStyle.var_613, (HabboWindowParam.var_829 | HabboWindowParam.var_158), new Rectangle(var_1612, var_1613, 2, 2), null, 0) as IWindowContainer);
            this._window.buildFromXML(XML(_loc2_.content));
            this._window.background = true;
            this._window.color = 0x1FFFFFF;
            _loc3_ = this._window.findChildByName("cancel");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _loc3_ = this._window.findChildByName("exchange");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _loc3_ = this._window.findChildByName("link");
            if (_loc3_ != null)
            {
                _loc3_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _loc3_ = this._window.findChildByTag("close");
            if (_loc3_ != null)
            {
                _loc3_.procedure = this.onWindowClose;
            };
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
        }

        private function hideInterface():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this.var_5281 = -1;
            this.var_5282 = 0;
        }

        private function sendRedeemMessage():void
        {
            var _loc1_:RoomWidgetCreditFurniRedeemMessage;
            if (this.var_5281 == -1)
            {
                return;
            };
            if (messageListener != null)
            {
                _loc1_ = new RoomWidgetCreditFurniRedeemMessage(RoomWidgetCreditFurniRedeemMessage.var_1626, this.var_5281);
                messageListener.processWidgetMessage(_loc1_);
                this.hideInterface();
            };
        }

        private function onMouseEvent(param1:WindowMouseEvent):void
        {
            var _loc4_:String;
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            switch (_loc3_)
            {
                case "link":
                    _loc4_ = localizations.getKey("widget.furni.info.url");
                    if (_loc4_.indexOf("http") == 0)
                    {
                        HabboWebTools.navigateToURL(_loc4_, "habboMain");
                    };
                    return;
                case "exchange":
                    this.sendRedeemMessage();
                    return;
                case "cancel":
                case "close":
                    this.hideInterface();
                    return;
            };
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.hideInterface();
        }


    }
}