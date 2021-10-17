package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
    import com.sulake.habbo.session.events.RoomSessionQueueEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
    import flash.events.Event;

    public class RoomQueueWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_405);
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
            var _loc1_:Array = [];
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1633);
            _loc1_.push(RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE);
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1635);
            _loc1_.push(RoomWidgetRoomQueueMessage.var_1634);
            return (_loc1_);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (((this._container == null) || (this._container.roomSession == null)))
            {
                return (null);
            };
            var _loc2_:RoomWidgetRoomQueueMessage = (param1 as RoomWidgetRoomQueueMessage);
            if (_loc2_ == null)
            {
                return (null);
            };
            switch (param1.type)
            {
                case RoomWidgetRoomQueueMessage.var_1633:
                    this._container.roomSession.quit();
                    break;
                case RoomWidgetRoomQueueMessage.CHANGE_TO_SPECTATOR_QUEUE:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent.var_1566);
                    break;
                case RoomWidgetRoomQueueMessage.var_1635:
                    this._container.roomSession.changeQueue(RoomSessionQueueEvent.var_1565);
                    break;
                case RoomWidgetRoomQueueMessage.var_1634:
                    if (this._container.catalog != null)
                    {
                        this._container.catalog.openCatalogPage(CatalogPageName.var_160, true);
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([RoomSessionQueueEvent.var_368]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:RoomSessionQueueEvent;
            var _loc3_:String;
            var _loc4_:Boolean;
            var _loc5_:Array;
            var _loc6_:int;
            var _loc7_:Boolean;
            var _loc8_:RoomWidgetRoomQueueUpdateEvent;
            if (((this._container == null) || (this._container.events == null)))
            {
                return;
            };
            switch (param1.type)
            {
                case RoomSessionQueueEvent.var_368:
                    _loc2_ = (param1 as RoomSessionQueueEvent);
                    if (_loc2_ == null)
                    {
                        return;
                    };
                    switch (_loc2_.queueSetTarget)
                    {
                        case RoomSessionQueueEvent.var_1565:
                            _loc3_ = RoomWidgetRoomQueueUpdateEvent.var_1631;
                            break;
                        case RoomSessionQueueEvent.var_1566:
                            _loc3_ = RoomWidgetRoomQueueUpdateEvent.var_1632;
                            break;
                    };
                    if (_loc3_ == null)
                    {
                        return;
                    };
                    _loc4_ = true;
                    if (this._container.inventory != null)
                    {
                        _loc4_ = (this._container.inventory.clubDays > 0);
                    };
                    _loc5_ = _loc2_.queueTypes;
                    _loc7_ = false;
                    if (_loc5_.length > 1)
                    {
                        if (((_loc4_) && (!(_loc2_.queueTypes.indexOf(RoomSessionQueueEvent.var_1563) == -1))))
                        {
                            _loc6_ = (_loc2_.getQueueSize(RoomSessionQueueEvent.var_1563) + 1);
                            _loc7_ = true;
                        }
                        else
                        {
                            _loc6_ = (_loc2_.getQueueSize(RoomSessionQueueEvent.var_1564) + 1);
                        };
                    }
                    else
                    {
                        _loc6_ = (_loc2_.getQueueSize(_loc5_[0]) + 1);
                    };
                    _loc8_ = new RoomWidgetRoomQueueUpdateEvent(_loc3_, _loc6_, _loc4_, _loc2_.isActive, _loc7_);
                    this._container.events.dispatchEvent(_loc8_);
                    return;
            };
        }

        public function update():void
        {
        }


    }
}