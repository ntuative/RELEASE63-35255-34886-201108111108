package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.room.events.RoomObjectFloorHoleEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureFloorHoleLogic extends FurnitureMultiStateLogic 
    {

        private static const var_1075:int = 0;

        private var var_4081:int = -1;
        private var var_4506:Vector3d = null;


        override public function dispose():void
        {
            if (this.var_4081 == var_1075)
            {
                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.var_459, object.getId(), object.getType()));
            };
            super.dispose();
        }

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFloorHoleEvent.var_456, RoomObjectFloorHoleEvent.var_459];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectDataUpdateMessage;
            var _loc3_:IVector3d;
            var _loc4_:int;
            super.processUpdateMessage(param1);
            if (object != null)
            {
                _loc2_ = (param1 as RoomObjectDataUpdateMessage);
                if (_loc2_ != null)
                {
                    _loc4_ = object.getState(0);
                    if (_loc4_ != this.var_4081)
                    {
                        if (eventDispatcher != null)
                        {
                            if (_loc4_ == var_1075)
                            {
                                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.var_456, object.getId(), object.getType()));
                            }
                            else
                            {
                                if (this.var_4081 == var_1075)
                                {
                                    eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.var_459, object.getId(), object.getType()));
                                };
                            };
                        };
                        this.var_4081 = _loc4_;
                    };
                };
                _loc3_ = object.getLocation();
                if (this.var_4506 == null)
                {
                    this.var_4506 = new Vector3d();
                }
                else
                {
                    if (((!(_loc3_.x == this.var_4506.x)) || (!(_loc3_.y == this.var_4506.y))))
                    {
                        if (this.var_4081 == var_1075)
                        {
                            if (eventDispatcher != null)
                            {
                                eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent(RoomObjectFloorHoleEvent.var_456, object.getId(), object.getType()));
                            };
                        };
                    };
                };
                this.var_4506.assign(_loc3_);
            };
        }


    }
}