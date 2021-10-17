package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
    import flash.events.Event;

    public class DoorbellWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_343);
        }

        public function set container(param1:IRoomWidgetHandlerContainer):void
        {
            this._container = param1;
        }

        public function dispose():void
        {
            this.var_1023 = true;
            this._container = null;
        }

        public function getWidgetMessages():Array
        {
            return ([RoomWidgetLetUserInMessage.var_2283]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetLetUserInMessage;
            switch (param1.type)
            {
                case RoomWidgetLetUserInMessage.var_2283:
                    _loc2_ = (param1 as RoomWidgetLetUserInMessage);
                    this._container.roomSession.letUserIn(_loc2_.userName, _loc2_.canEnter);
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionDoorbellEvent.var_343, RoomSessionDoorbellEvent.var_344, RoomSessionDoorbellEvent.var_345]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionDoorbellEvent;
            switch (param1.type)
            {
                case RoomSessionDoorbellEvent.var_343:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_1636, _loc2_.userName));
                    return;
                case RoomSessionDoorbellEvent.var_344:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_344, _loc2_.userName));
                    return;
                case RoomSessionDoorbellEvent.var_345:
                    _loc2_ = (param1 as RoomSessionDoorbellEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetDoorbellEvent(RoomWidgetDoorbellEvent.var_345, _loc2_.userName));
                    return;
            };
        }

        public function update():void
        {
        }


    }
}