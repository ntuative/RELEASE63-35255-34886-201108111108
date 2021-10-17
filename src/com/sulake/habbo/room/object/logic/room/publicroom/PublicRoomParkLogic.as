package com.sulake.habbo.room.object.logic.room.publicroom
{
    import com.sulake.habbo.room.events.RoomObjectRoomActionEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomParkLogic extends PublicRoomLogic 
    {

        private static const var_1070:String = "goawaybus";
        private static const var_1071:String = "bus";
        private static const var_1072:String = "bus_oviopen_hidden";


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectRoomActionEvent.var_1068, RoomObjectRoomActionEvent.var_1069];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            super.mouseEvent(param1, param2);
            var _loc3_:RoomSpriteMouseEvent = param1;
            if (_loc3_ == null)
            {
                return;
            };
            if (object == null)
            {
                return;
            };
            var _loc4_:int = object.getId();
            var _loc5_:String = object.getType();
            var _loc6_:RoomObjectEvent;
            switch (_loc3_.type)
            {
                case MouseEvent.CLICK:
                    switch (_loc3_.spriteTag)
                    {
                        case var_1070:
                            _loc6_ = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.var_1068, 0, _loc4_, _loc5_);
                            break;
                        case var_1071:
                        case var_1072:
                            _loc6_ = new RoomObjectRoomActionEvent(RoomObjectRoomActionEvent.var_1069, 0, _loc4_, _loc5_);
                            break;
                    };
                    break;
            };
            if (eventDispatcher != null)
            {
                if (_loc6_ != null)
                {
                    eventDispatcher.dispatchEvent(_loc6_);
                };
            };
        }


    }
}