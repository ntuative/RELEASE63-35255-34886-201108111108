package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;

    public class FurnitureClothingChangeLogic extends FurnitureLogic 
    {


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectWidgetRequestEvent.var_401];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function initialize(param1:XML):void
        {
            super.initialize(param1);
            if (((object == null) || (object.getModel() == null)))
            {
                return;
            };
            var _loc2_:String = object.getModel().getString(RoomObjectVariableEnum.var_525);
            this.updateClothingData(_loc2_);
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(param1);
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ != null)
            {
                this.updateClothingData(_loc2_.data);
            };
        }

        private function updateClothingData(param1:String):void
        {
            var _loc2_:Array;
            if (((!(param1 == null)) && (param1.length > 0)))
            {
                _loc2_ = param1.split(",");
                if (_loc2_.length > 0)
                {
                    object.getModelController().setString(RoomObjectVariableEnum.var_775, _loc2_[0]);
                };
                if (_loc2_.length > 1)
                {
                    object.getModelController().setString(RoomObjectVariableEnum.var_774, _loc2_[1]);
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
                _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_401, _loc1_, _loc2_);
                eventDispatcher.dispatchEvent(_loc3_);
            };
        }


    }
}