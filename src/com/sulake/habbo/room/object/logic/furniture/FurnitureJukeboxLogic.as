package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import flash.events.MouseEvent;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.events.RoomObjectEvent;
    import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;

    public class FurnitureJukeboxLogic extends FurnitureMultiStateLogic 
    {

        private var var_4510:Boolean;
        private var _isInitialized:Boolean = false;
        private var var_4081:int = -1;


        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectFurnitureActionEvent.var_1079, RoomObjectFurnitureActionEvent.var_1080, RoomObjectFurnitureActionEvent.var_1081, RoomObjectFurnitureActionEvent.var_1082, RoomObjectWidgetRequestEvent.var_402];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function dispose():void
        {
            this.requestDispose();
            super.dispose();
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectDataUpdateMessage;
            var _loc3_:IRoomObjectModelController;
            var _loc4_:int;
            super.processUpdateMessage(param1);
            if (object == null)
            {
                return;
            };
            if (!this._isInitialized)
            {
                this.requestInit();
            };
            if (object.getModelController().getNumber(RoomObjectVariableEnum.var_502) == 1)
            {
                object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.var_1062, RoomWidgetInfostandExtraParamEnum.var_1083);
                _loc2_ = (param1 as RoomObjectDataUpdateMessage);
                if (_loc2_ == null)
                {
                    return;
                };
                _loc3_ = object.getModelController();
                if (_loc3_ == null)
                {
                    return;
                };
                _loc4_ = object.getState(0);
                if (_loc4_ != this.var_4081)
                {
                    this.var_4081 = _loc4_;
                    if (_loc4_ == 1)
                    {
                        this.requestPlayList();
                    }
                    else
                    {
                        if (_loc4_ == 0)
                        {
                            this.requestStopPlaying();
                        };
                    };
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
                _loc3_ = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.var_402, _loc1_, _loc2_);
                eventDispatcher.dispatchEvent(_loc3_);
                eventDispatcher.dispatchEvent(new RoomObjectStateChangeEvent(RoomObjectStateChangeEvent.var_1038, _loc1_, _loc2_, -1));
            };
        }

        private function requestInit():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            this.var_4510 = true;
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1082, object.getId(), object.getType());
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
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1079, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestStopPlaying():void
        {
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1080, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }

        private function requestDispose():void
        {
            if (!this.var_4510)
            {
                return;
            };
            if (((object == null) || (eventDispatcher == null)))
            {
                return;
            };
            var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.var_1081, object.getId(), object.getType());
            eventDispatcher.dispatchEvent(_loc1_);
        }


    }
}