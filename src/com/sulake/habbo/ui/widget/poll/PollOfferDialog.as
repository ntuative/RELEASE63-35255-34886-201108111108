package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;
    import com.sulake.core.window.events.WindowEvent;

    public class PollOfferDialog implements IPollDialog 
    {

        public static const var_2530:String = "POLL_OFFER_STATE_OK";
        public static const var_2531:String = "POLL_OFFER_STATE_CANCEL";
        public static const var_608:String = "POLL_OFFER_STATE_UNKNOWN";

        private var _disposed:Boolean = false;
        private var _window:IFrameWindow;
        private var _state:String = "POLL_OFFER_STATE_UNKNOWN";
        private var _widget:PollWidget;
        private var _id:int = -1;

        public function PollOfferDialog(param1:int, param2:String, param3:PollWidget)
        {
            var _loc5_:IWindow;
            var _loc6_:IWindow;
            var _loc7_:IWindow;
            var _loc8_:IWindow;
            var _loc9_:ITextWindow;
            var _loc10_:IItemListWindow;
            super();
            this._id = param1;
            this._widget = param3;
            var _loc4_:XmlAsset = (this._widget.assets.getAssetByName("poll_offer") as XmlAsset);
            if (_loc4_ != null)
            {
                this._window = (this._widget.windowManager.buildFromXML((_loc4_.content as XML)) as IFrameWindow);
                if (this._window)
                {
                    this._window.center();
                    _loc5_ = this._window.findChildByName("poll_offer_button_ok");
                    if (_loc5_ != null)
                    {
                        _loc5_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
                    };
                    _loc6_ = this._window.findChildByName("poll_offer_button_cancel");
                    if (_loc6_ != null)
                    {
                        _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
                    };
                    _loc7_ = this._window.findChildByName("poll_offer_button_later");
                    if (_loc7_ != null)
                    {
                        _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLater);
                    };
                    _loc8_ = this._window.findChildByName("header_button_close");
                    if (_loc8_ != null)
                    {
                        _loc8_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
                    };
                    _loc9_ = (this._window.findChildByName("poll_offer_summary") as ITextWindow);
                    if (_loc9_)
                    {
                        _loc9_.htmlText = param2;
                        _loc10_ = (this._window.findChildByName("poll_offer_summary_wrapper") as IItemListWindow);
                        if (_loc10_)
                        {
                            this._window.height = (this._window.height + (_loc10_.scrollableRegion.height - _loc10_.visibleRegion.height));
                        };
                    };
                };
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get state():String
        {
            return (this._state);
        }

        public function start():void
        {
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            this._disposed = true;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            this._widget = null;
        }

        private function onOk(param1:WindowEvent):void
        {
            if (this._state != var_608)
            {
                return;
            };
            this._state = var_2530;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_2323, this._id));
        }

        private function onCancel(param1:WindowEvent):void
        {
            if (this._state != var_608)
            {
                return;
            };
            this._state = var_2531;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_2322, this._id));
            this._widget.pollCancelled(this._id);
        }

        private function onLater(param1:WindowEvent):void
        {
            if (this._state != var_608)
            {
                return;
            };
            this._state = var_2531;
            this._widget.pollCancelled(this._id);
        }

        private function onClose(param1:WindowEvent):void
        {
            if (this._state != var_608)
            {
                return;
            };
            this._state = var_2531;
            this._widget.messageListener.processWidgetMessage(new RoomWidgetPollMessage(RoomWidgetPollMessage.var_2322, this._id));
            this._widget.pollCancelled(this._id);
        }


    }
}