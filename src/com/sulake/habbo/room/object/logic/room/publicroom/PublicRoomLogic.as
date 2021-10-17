package com.sulake.habbo.room.object.logic.room.publicroom
{
    import com.sulake.habbo.room.object.logic.room.RoomLogic;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import flash.utils.getTimer;
    import com.sulake.habbo.room.RoomVariableEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.MouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomLogic extends RoomLogic 
    {

        private var var_2709:Boolean = false;
        private var var_4529:int = 0;


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectRoomAdEvent.var_49, RoomObjectRoomAdEvent.var_321, RoomObjectRoomAdEvent.var_322];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function initialize(param1:XML):void
        {
            super.initialize(param1);
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            var _loc2_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc2_ == null)
            {
                return;
            };
            _loc2_.setString(RoomObjectVariableEnum.var_528, "");
            _loc2_.setString(RoomObjectVariableEnum.var_788, "");
            _loc2_.setNumber(RoomObjectVariableEnum.var_789, Number(false));
            this.var_2709 = true;
        }

        override public function update(param1:int):void
        {
            super.update(param1);
            if (((this.var_4529 > 0) && (param1 > this.var_4529)))
            {
                this.adDelayTimeout();
                this.var_4529 = 0;
            };
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            if (((param1 == null) || (object == null)))
            {
                return;
            };
            var _loc2_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:RoomObjectRoomAdUpdateMessage = (param1 as RoomObjectRoomAdUpdateMessage);
            if (_loc3_ != null)
            {
                switch (_loc3_.type)
                {
                    case RoomObjectRoomAdUpdateMessage.var_531:
                        _loc2_.setString(RoomObjectVariableEnum.var_528, _loc3_.asset);
                        _loc2_.setString(RoomObjectVariableEnum.var_788, _loc3_.clickUrl);
                        _loc2_.setNumber(RoomObjectVariableEnum.var_789, Number(true));
                        this.var_4529 = (getTimer() + _loc2_.getNumber(RoomVariableEnum.var_475));
                        return;
                };
            };
        }

        public function adDelayTimeout():void
        {
            if (object == null)
            {
                return;
            };
            var _loc1_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc1_ == null)
            {
                return;
            };
            _loc1_.setNumber(RoomObjectVariableEnum.var_789, Number(false));
        }

        override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry):void
        {
            var _loc7_:String;
            super.mouseEvent(param1, param2);
            var _loc3_:RoomSpriteMouseEvent = param1;
            if (_loc3_ == null)
            {
                return;
            };
            if (((object == null) || (param1 == null)))
            {
                return;
            };
            var _loc4_:IRoomObjectModelController = (object.getModel() as IRoomObjectModelController);
            if (_loc4_ == null)
            {
                return;
            };
            var _loc5_:int = object.getId();
            var _loc6_:String = object.getType();
            switch (_loc3_.type)
            {
                case MouseEvent.CLICK:
                    if (_loc3_.spriteTag == RoomObjectVariableEnum.var_787)
                    {
                        _loc7_ = _loc4_.getString(RoomObjectVariableEnum.var_788);
                        if (((!(_loc7_ == null)) && (_loc7_.indexOf("http") == 0)))
                        {
                            eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_49, _loc5_, _loc6_, _loc7_));
                            HabboWebTools.openWebPage(_loc7_);
                        };
                    };
                    return;
                case MouseEvent.ROLL_OVER:
                    if (_loc3_.spriteTag == RoomObjectVariableEnum.var_787)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_321, _loc5_, _loc6_));
                    };
                    return;
                case MouseEvent.ROLL_OUT:
                    if (_loc3_.spriteTag == RoomObjectVariableEnum.var_787)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_322, _loc5_, _loc6_));
                    };
                    return;
            };
        }


    }
}