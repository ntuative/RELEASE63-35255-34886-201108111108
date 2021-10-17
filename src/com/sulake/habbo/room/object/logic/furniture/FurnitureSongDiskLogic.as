package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSongDiskLogic extends FurnitureLogic 
    {


        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:String;
            var _loc3_:int;
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum.var_502) == 1)
            {
                _loc2_ = object.getModelController().getString(RoomObjectVariableEnum.var_521);
                _loc3_ = int(_loc2_);
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.var_1062, (RoomWidgetInfostandExtraParamEnum.var_1092 + _loc3_));
            };
        }


    }
}