package com.sulake.habbo.ui.widget.furniture.ecotronbox
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;

    public class EcotronBoxFurniWidget extends RoomWidgetBase 
    {

        private static const var_1612:Number = 100;
        private static const var_1613:Number = 100;

        private var _window:IWindowContainer;
        private var var_1678:int = -1;
        private var _text:String;
        private var var_2438:Boolean;
        private var var_5295:Boolean = false;

        public function EcotronBoxFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManager, param3:IAssetLibrary=null)
        {
            super(param1, param2, param3);
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
            param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1618, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1619, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1618, this.onPresentUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1618, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1619, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1618, this.onPresentUpdate);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1542, this.onRoomObjectRemoved);
        }

        private function onObjectUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            this.hideInterface();
            switch (param1.type)
            {
                case RoomWidgetEcotronBoxDataUpdateEvent.var_1618:
                    this.var_5295 = false;
                    this.var_1678 = param1.objectId;
                    this._text = param1.text;
                    this.var_2438 = param1.controller;
                    this.showInterface();
                    return;
                case RoomWidgetEcotronBoxDataUpdateEvent.var_1619:
                    if (!this.var_5295)
                    {
                        return;
                    };
                    this.var_1678 = param1.objectId;
                    this.showInterface();
                    this.showIcon(param1.iconBitmapData);
                    this.showDescription(param1.text);
                    this.setOpenButton(false);
                    return;
            };
        }

        private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (param1.id == this.var_1678)
            {
                this.hideInterface();
            };
        }

        private function onPresentUpdate(param1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetPresentDataUpdateEvent.var_1618:
                    this.hideInterface();
                    return;
            };
        }

        private function showIcon(param1:BitmapData):void
        {
            if (param1 == null)
            {
                param1 = new BitmapData(1, 1);
            };
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("ecotronbox_card_preview") as IBitmapWrapperWindow);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = int(((_loc2_.width - param1.width) / 2));
            var _loc4_:int = int(((_loc2_.height - param1.height) / 2));
            if (_loc2_.bitmap == null)
            {
                _loc2_.bitmap = new BitmapData(_loc2_.width, _loc2_.height, true, 0xFFFFFF);
            };
            _loc2_.bitmap.fillRect(_loc2_.bitmap.rect, 0xFFFFFF);
            _loc2_.bitmap.copyPixels(param1, param1.rect, new Point(_loc3_, _loc4_), null, null, false);
        }

        private function showDescription(param1:String):void
        {
            var _loc2_:ITextWindow;
            _loc2_ = (this._window.findChildByName("ecotronbox_card_msg") as ITextWindow);
            if (((!(_loc2_ == null)) && (!(param1 == null))))
            {
                _loc2_.caption = param1;
            };
        }

        private function showInterface():void
        {
            var _loc3_:BitmapDataAsset;
            var _loc4_:BitmapData;
            var _loc5_:IBitmapWrapperWindow;
            var _loc6_:ITextWindow;
            var _loc7_:IWindow;
            if (this.var_1678 < 0)
            {
                return;
            };
            var _loc1_:IAsset = assets.getAssetByName("ecotronbox_card");
            var _loc2_:XmlAsset = XmlAsset(_loc1_);
            if (_loc2_ == null)
            {
                return;
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            this._window = (windowManager.createWindow("ecotronboxcardui_container", "", HabboWindowType.var_218, HabboWindowStyle.var_613, (HabboWindowParam.var_829 | HabboWindowParam.var_158), new Rectangle(var_1612, var_1613, 2, 2), null, 0) as IWindowContainer);
            this._window.buildFromXML(XML(_loc2_.content));
            _loc3_ = (assets.getAssetByName("ecotronbox_card_bg") as BitmapDataAsset);
            _loc5_ = (this._window.findChildByName("ecotronbox_card_bg") as IBitmapWrapperWindow);
            if (_loc3_ != null)
            {
                _loc4_ = (_loc3_.content as BitmapData);
                _loc5_.bitmap = _loc4_.clone();
            };
            _loc6_ = (this._window.findChildByName("ecotronbox_card_date") as ITextWindow);
            if (((!(_loc6_ == null)) && (!(this._text == null))))
            {
                _loc6_.caption = this._text;
            };
            _loc7_ = this._window.findChildByName("ecotronbox_card_btn_close");
            if (_loc7_ != null)
            {
                _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            this.setOpenButton(true);
        }

        private function setOpenButton(param1:Boolean):void
        {
            var _loc2_:IWindow;
            if (this._window == null)
            {
                return;
            };
            _loc2_ = this._window.findChildByName("ecotronbox_card_btn_open");
            if (_loc2_ != null)
            {
                if (((this.var_2438) && (param1)))
                {
                    _loc2_.visible = true;
                    _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                }
                else
                {
                    _loc2_.visible = false;
                };
            };
        }

        private function hideInterface():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (!this.var_5295)
            {
                this.var_1678 = -1;
            };
            this._text = "";
            this.var_2438 = false;
        }

        private function sendOpen():void
        {
            var _loc1_:RoomWidgetEcotronBoxOpenMessage;
            if ((((this.var_5295) || (this.var_1678 == -1)) || (!(this.var_2438))))
            {
                return;
            };
            this.var_5295 = true;
            if (messageListener != null)
            {
                _loc1_ = new RoomWidgetEcotronBoxOpenMessage(RoomWidgetEcotronBoxOpenMessage.var_1624, this.var_1678);
                messageListener.processWidgetMessage(_loc1_);
            };
        }

        private function onMouseEvent(param1:WindowMouseEvent):void
        {
            var _loc2_:IWindow = (param1.target as IWindow);
            var _loc3_:String = _loc2_.name;
            switch (_loc3_)
            {
                case "ecotronbox_card_btn_open":
                    this.sendOpen();
                    return;
                case "ecotronbox_card_btn_close":
                default:
                    this.var_5295 = false;
                    this.hideInterface();
            };
        }


    }
}