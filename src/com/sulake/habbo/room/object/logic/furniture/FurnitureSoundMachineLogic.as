package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class FurnitureSoundMachineLogic extends FurnitureMultiStateLogic 
    {

        private var var_4510:Boolean;
        private var _isInitialized:Boolean = false;
        private var var_4081:int = -1;


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_1051, RoomObjectFurnitureActionEvent.var_1052, RoomObjectFurnitureActionEvent.var_1053, RoomObjectFurnitureActionEvent.var_1054];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (!this._isInitialized)
            {
                this.requestInitialize();
            };
            var _loc2_:RoomObjectDataUpdateMessage = (param1 as RoomObjectDataUpdateMessage);
            if (_loc2_ == null)
            {
                return;
            };
            var _loc3_:int = object.getState(0);
            if (_loc3_ != this.var_4081)
            {
                this.var_4081 = _loc3_;
                if (_loc3_ == 1)
                {
                    this.requestPlayList();
                }
                else
                {
                    if (_loc3_ == 0)
                    {
                        this.requestStopPlaying();
                    };
                };
            };
        }

        private function requestInitialize():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_4510 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1054, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
            this._isInitialized = true;
        }

        private function requestPlayList():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_4510 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1051, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestStopPlaying():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1052, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestDispose():void
        {
            if (!this.var_4510)
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1053, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }


    }
}