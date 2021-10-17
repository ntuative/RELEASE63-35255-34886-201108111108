package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureWelcomeGiftLogic extends FurnitureMultiStateLogic 
    {


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
                case MouseEvent.CLICK:
                    _loc3_ = object.getId();
                    _loc4_ = object.getType();
                    if (eventDispatcher != null)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.var_1038, _loc3_, _loc4_));
                    };
                    break;
            };
            super.mouseEvent(param1, param2);
        }


    }
}