package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectDimmerStateUpdateEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureRoomDimmerLogic extends FurnitureLogic 
    {

        private var var_4525:Boolean = false;


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.var_395, RoomObjectWidgetRequestEvent.var_400, RoomObjectDimmerStateUpdateEvent.var_380];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            if (((param1 == null) || (param2 == null)))
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            switch (param1.type)
            {
                case MouseEvent.DOUBLE_CLICK:
                    this.useObject();
                    return;
                default:
                    super.mouseEvent(param1, param2);
            };
        }

        override public function useObject():void
        {
            var _loc1_:int;
            var _loc2_:String;
            var _loc3_:RoomObjectEvent;
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _loc1_ = object.getId();
                _loc2_ = object.getType();
                _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_395, _loc1_, _loc2_);
                eventDispatcher.dispatchEvent(_loc3_);
            };
        }

        override public function dispose():void
        {
            var _loc1_:int;
            var _loc2_:String;
            var _loc3_:RoomObjectDimmerStateUpdateEvent;
            var _loc4_:int;
            var _loc5_:uint;
            var _loc6_:int;
            var _loc7_:RoomObjectEvent;
            if (this.var_4525)
            {
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    _loc1_ = object.getId();
                    _loc2_ = object.getType();
                    _loc4_ = 0;
                    _loc5_ = 0xFFFFFF;
                    _loc6_ = 0xFF;
                    _loc3_ = new RoomObjectDimmerStateUpdateEvent(_loc1_, _loc2_, 0, 1, 1, _loc5_, _loc6_);
                    eventDispatcher.dispatchEvent(_loc3_);
                    _loc7_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_400, _loc1_, _loc2_);
                    eventDispatcher.dispatchEvent(_loc7_);
                };
                this.var_4525 = false;
            };
            super.dispose();
        }

        private function dispatchColorUpdateEvent(param1:String):void
        {
            var _loc3_:int;
            var _loc4_:int;
            var _loc5_:int;
            var _loc6_:String;
            var _loc7_:uint;
            var _loc8_:int;
            var _loc9_:int;
            var _loc10_:String;
            var _loc11_:RoomObjectDimmerStateUpdateEvent;
            if (param1 == null)
            {
                return;
            };
            var _loc2_:Array = param1.split(",");
            if (_loc2_.length >= 5)
            {
                _loc3_ = this.readState(param1);
                _loc4_ = parseInt(_loc2_[1]);
                _loc5_ = parseInt(_loc2_[2]);
                _loc6_ = _loc2_[3];
                _loc7_ = parseInt(_loc6_.substr(1), 16);
                _loc8_ = parseInt(_loc2_[4]);
                if (_loc3_ == 0)
                {
                    _loc7_ = 0xFFFFFF;
                    _loc8_ = 0xFF;
                };
                if (((!(eventDispatcher == null)) && (!(object == null))))
                {
                    _loc9_ = object.getId();
                    _loc10_ = object.getType();
                    _loc11_ = null;
                    _loc11_ = new RoomObjectDimmerStateUpdateEvent(_loc9_, _loc10_, _loc3_, _loc4_, _loc5_, _loc7_, _loc8_);
                    eventDispatcher.dispatchEvent(_loc11_);
                    this.var_4525 = true;
                };
            };
        }

        private function readState(param1:String):int
        {
            var _loc3_:int;
            if (param1 == null)
            {
                return (0);
            };
            var _loc2_:Array = param1.split(",");
            if (_loc2_.length >= 5)
            {
                return (parseInt(_loc2_[0]) - 1);
            };
            return (0);
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc4_:int;
            var _loc2_:IRoomObjectModelController = object.getModelController();
            var _loc3_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc3_ != null)
            {
                if (_loc3_.data != null)
                {
                    this.dispatchColorUpdateEvent(_loc3_.data);
                    _loc4_ = this.readState(_loc3_.data);
                    _loc3_ = new RoomObjectDataUpdateMessage(_loc4_, _loc3_.data);
                    super.processUpdateMessage(_loc3_);
                };
                return;
            };
            super.processUpdateMessage(param1);
        }

        override public function update(param1:int):void
        {
            var _loc2_:String;
            super.update(param1);
            if (((!(object == null)) && (!(object.getModelController() == null))))
            {
                _loc2_ = object.getModelController().getString(RoomObjectVariableEnum.var_525);
                if (((!(_loc2_ == null)) && (_loc2_.length > 0)))
                {
                    object.getModelController().setString(RoomObjectVariableEnum.var_525, "");
                    this.dispatchColorUpdateEvent(_loc2_);
                };
            };
        }


    }
}