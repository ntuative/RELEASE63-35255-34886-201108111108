package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStickieSendUpdateMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureStickieWidgetHandler implements IRoomWidgetHandler 
    {

        private var var_1023:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;


        public function get disposed():Boolean
        {
            return (this.var_1023);
        }

        public function get type():String
        {
            return (RoomWidgetEnum.var_412);
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
            return ([RoomWidgetFurniToWidgetMessage.var_1548, RoomWidgetStickieSendUpdateMessage.var_1615, RoomWidgetStickieSendUpdateMessage.var_1614]);
        }

        public function processWidgetMessage(param1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _loc2_:RoomWidgetFurniToWidgetMessage;
            var _loc3_:IRoomObject;
            var _loc4_:RoomWidgetStickieSendUpdateMessage;
            var _loc5_:RoomWidgetStickieSendUpdateMessage;
            var _loc6_:IRoomObjectModel;
            var _loc7_:String;
            var _loc8_:String;
            var _loc9_:String;
            var _loc10_:Boolean;
            var _loc11_:RoomWidgetStickieDataUpdateEvent;
            switch (param1.type)
            {
                case RoomWidgetFurniToWidgetMessage.var_1548:
                    _loc2_ = (param1 as RoomWidgetFurniToWidgetMessage);
                    _loc3_ = this._container.roomEngine.getRoomObject(_loc2_.roomId, _loc2_.roomCategory, _loc2_.id, _loc2_.category);
                    if (_loc3_ != null)
                    {
                        _loc6_ = _loc3_.getModel();
                        if (_loc6_ != null)
                        {
                            _loc7_ = _loc6_.getString(RoomObjectVariableEnum.var_763);
                            if (_loc7_.length < 6)
                            {
                                return (null);
                            };
                            _loc9_ = "";
                            if (_loc7_.indexOf(" ") > 0)
                            {
                                _loc8_ = _loc7_.slice(0, _loc7_.indexOf(" "));
                                _loc9_ = _loc7_.slice((_loc7_.indexOf(" ") + 1), _loc7_.length);
                            }
                            else
                            {
                                _loc8_ = _loc7_;
                            };
                            _loc10_ = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
                            _loc11_ = new RoomWidgetStickieDataUpdateEvent(RoomWidgetStickieDataUpdateEvent.var_1611, _loc2_.id, _loc3_.getType(), _loc9_, _loc8_, _loc10_);
                            this._container.events.dispatchEvent(_loc11_);
                        };
                    };
                    break;
                case RoomWidgetStickieSendUpdateMessage.var_1614:
                    _loc4_ = (param1 as RoomWidgetStickieSendUpdateMessage);
                    if (_loc4_ == null)
                    {
                        return (null);
                    };
                    if (((!(this._container == null)) && (!(this._container.roomEngine == null))))
                    {
                        this._container.roomEngine.modifyRoomObjectData(_loc4_.objectId, RoomObjectCategoryEnum.var_71, ((_loc4_.colorHex + " ") + _loc4_.text));
                    };
                    break;
                case RoomWidgetStickieSendUpdateMessage.var_1615:
                    _loc5_ = (param1 as RoomWidgetStickieSendUpdateMessage);
                    if (_loc5_ == null)
                    {
                        return (null);
                    };
                    if (((!(this._container == null)) && (!(this._container.roomEngine == null))))
                    {
                        this._container.roomEngine.deleteRoomObject(_loc5_.objectId, RoomObjectCategoryEnum.var_71);
                    };
                    break;
            };
            return (null);
        }

        public function getProcessedEvents():Array
        {
            return ([]);
        }

        public function processEvent(param1:Event):void
        {
            var _loc2_:Event;
        }

        public function update():void
        {
        }


    }
}