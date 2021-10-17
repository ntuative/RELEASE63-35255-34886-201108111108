package com.sulake.habbo.room.object.logic.room
{
    import com.sulake.room.object.logic.ObjectLogicBase;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectVisibilityUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomTileCursorLogic extends ObjectLogicBase 
    {


        override public function initialize(param1:XML):void
        {
            var _loc2_:IRoomObjectModelController;
            if (object != null)
            {
                _loc2_ = object.getModelController();
                if (_loc2_ != null)
                {
                    _loc2_.setNumber(RoomObjectVariableEnum.var_150, 1);
                    object.setState(1, 0);
                };
            };
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(param1);
            var _loc2_:RoomObjectVisibilityUpdateMessage = (param1 as RoomObjectVisibilityUpdateMessage);
            if (_loc2_ != null)
            {
                if (_loc2_.type == RoomObjectVisibilityUpdateMessage.var_1045)
                {
                    if (object != null)
                    {
                        object.setState(0, 0);
                    };
                }
                else
                {
                    if (_loc2_.type == RoomObjectVisibilityUpdateMessage.var_1046)
                    {
                        if (object != null)
                        {
                            object.setState(1, 0);
                        };
                    };
                };
            };
        }


    }
}