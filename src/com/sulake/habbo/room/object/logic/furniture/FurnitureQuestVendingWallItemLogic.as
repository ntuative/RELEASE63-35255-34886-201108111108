package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureQuestVendingWallItemLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_1076];
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
            if (((!(eventDispatcher == null)) && (!(object == null))))
            {
                _loc1_ = object.getId();
                _loc2_ = object.getType();
                eventDispatcher.dispatchEvent(new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1076, _loc1_, _loc2_));
            };
        }


    }
}