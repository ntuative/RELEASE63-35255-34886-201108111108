package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.effects.EffectsWidget;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.inventory.events.HabboInventoryEffectsEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class EffectsWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _widget:EffectsWidget;


        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                this.container = null;
                this._widget = null;
                this._disposed = true;
            };
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_252);
        }

        public function set widget(param1:EffectsWidget):void
        {
            this._widget = param1;
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null)
            {
                this._container.inventory.events.removeEventListener(HabboInventoryEffectsEvent.var_257, this.onEffectsChanged);
            };
            this._container = param1;
            if (this._container != null)
            {
                this._container.inventory.events.addEventListener(HabboInventoryEffectsEvent.var_257, this.onEffectsChanged);
            };
        }

        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }

        private function onEffectsChanged(param1:HabboInventoryEffectsEvent):void
        {
            if (this._widget)
            {
                this._widget.open();
            };
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetRequestWidgetMessage.var_2275]);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!param1)
            {
                return (null);
            };
            switch (param1.type)
            {
                case RoomWidgetRequestWidgetMessage.var_2275:
                    this._widget.open();
                    break;
            };
            return (null);
        }

        public function processEvent(param1:Event):void
        {
        }

        public function update():void
        {
        }


    }
}