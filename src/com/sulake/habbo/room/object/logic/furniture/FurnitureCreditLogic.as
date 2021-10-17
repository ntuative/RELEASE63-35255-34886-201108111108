package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurnitureCreditLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            super.dispose();
        }

        override public function initialize(param1:XML):void
        {
            var _loc4_:IRoomObjectModelController;
            super.initialize(param1);
            if (param1 == null)
            {
                return;
            };
            var _loc2_:XMLList = param1.credits;
            if (_loc2_.length() == 0)
            {
                return;
            };
            var _loc3_:Number = Number(_loc2_[0].@value);
            if (object != null)
            {
                _loc4_ = object.getModelController();
                if (_loc4_ != null)
                {
                    _loc4_.setNumber(RoomObjectVariableEnum.var_765, _loc3_);
                };
            };
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
                _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.ROOM_OBJECT_WIDGET_REQUEST_CREDITFURNI, _loc1_, _loc2_);
                eventDispatcher.dispatchEvent(_loc3_);
            };
        }


    }
}