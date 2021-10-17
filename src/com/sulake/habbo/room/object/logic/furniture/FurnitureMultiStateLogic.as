package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureMultiStateLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_455, RoomObjectFurnitureActionEvent.var_1041];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc3_:int;
            var _loc4_:String;
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
                case MouseEvent.ROLL_OVER:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_455, _loc3_, _loc4_));
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1041, _loc3_, _loc4_));
                    break;
            };
            super.mouseEvent(param1, param2);
        }


    }
}