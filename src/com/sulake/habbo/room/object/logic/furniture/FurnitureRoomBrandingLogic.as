package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
    import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
    import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
    import com.sulake.room.messages.RoomObjectUpdateMessage;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;

    public class FurnitureRoomBrandingLogic extends FurnitureLogic 
    {

        public static const var_1056:String = "state";
        public static const var_1057:String = "imageUrl";
        public static const var_1058:String = "clickUrl";
        public static const var_1059:String = "offsetX";
        public static const var_1060:String = "offsetY";
        public static const var_1061:String = "offsetZ";

        protected var var_4524:Boolean;
        protected var var_4523:Boolean;

        public function FurnitureRoomBrandingLogic()
        {
            this.var_4524 = true;
            this.var_4523 = false;
        }

        override public function initialize(param1:XML):void
        {
            super.initialize(param1);
            if (this.var_4524)
            {
                object.getModelController().setNumber(RoomObjectVariableEnum.var_773, 1);
            };
        }

        override public function getEventTypes():Array
        {
            var _loc1_:Array = [RoomObjectRoomAdEvent.var_319];
            return (getAllEventTypes(super.getEventTypes(), _loc1_));
        }

        override public function processUpdateMessage(param1:RoomObjectUpdateMessage):void
        {
            var _loc2_:RoomObjectRoomAdUpdateMessage;
            super.processUpdateMessage(param1);
            if ((param1 is RoomObjectDataUpdateMessage))
            {
                this.setupImageFromFurnitureData();
            };
            if ((param1 is RoomObjectRoomAdUpdateMessage))
            {
                _loc2_ = (param1 as RoomObjectRoomAdUpdateMessage);
                switch (_loc2_.type)
                {
                    case RoomObjectRoomAdUpdateMessage.var_532:
                        object.getModelController().setNumber(RoomObjectVariableEnum.var_768, 1, false);
                        return;
                    case RoomObjectRoomAdUpdateMessage.var_533:
                        object.getModelController().setNumber(RoomObjectVariableEnum.var_768, -1);
                        Logger.log(("failed to load billboard image from url " + object.getModelController().getString(RoomObjectVariableEnum.var_769)));
                        return;
                };
            };
        }

        private function setupImageFromFurnitureData():Boolean
        {
            var _loc2_:String;
            var _loc3_:Array;
            var _loc4_:String;
            var _loc5_:String;
            var _loc6_:int;
            var _loc7_:int;
            var _loc8_:int;
            var _loc9_:String;
            var _loc10_:String;
            var _loc11_:Array;
            var _loc12_:String;
            var _loc13_:String;
            var _loc14_:Number;
            var _loc15_:String;
            var _loc16_:String;
            var _loc17_:int;
            var _loc1_:Boolean;
            if (object != null)
            {
                _loc2_ = object.getModel().getString(RoomObjectVariableEnum.var_525);
                if (_loc2_ != null)
                {
                    _loc3_ = _loc2_.split("\t");
                    if (_loc3_ != null)
                    {
                        for each (_loc10_ in _loc3_)
                        {
                            _loc11_ = _loc10_.split("=", 2);
                            if (((!(_loc11_ == null)) && (_loc11_.length == 2)))
                            {
                                _loc12_ = _loc11_[0];
                                _loc13_ = _loc11_[1];
                                switch (_loc12_)
                                {
                                    case var_1056:
                                        _loc14_ = parseInt(_loc13_);
                                        if (!isNaN(_loc14_))
                                        {
                                            _loc17_ = int(_loc14_);
                                            if (object.getState(0) != _loc17_)
                                            {
                                                object.setState(_loc17_, 0);
                                                _loc1_ = true;
                                            };
                                        };
                                        break;
                                    case var_1057:
                                        _loc15_ = object.getModelController().getString(RoomObjectVariableEnum.var_769);
                                        if (((_loc15_ == null) || (!(_loc15_ == _loc13_))))
                                        {
                                            object.getModelController().setString(RoomObjectVariableEnum.var_769, _loc13_, false);
                                            object.getModelController().setNumber(RoomObjectVariableEnum.var_768, 0, false);
                                            _loc1_ = true;
                                        };
                                        break;
                                    case var_1058:
                                        _loc16_ = object.getModelController().getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
                                        if (((_loc16_ == null) || (!(_loc16_ == _loc13_))))
                                        {
                                            object.getModelController().setString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL, _loc13_);
                                            _loc1_ = true;
                                        };
                                        break;
                                    case var_1059:
                                        _loc1_ = this.updateOffset(RoomObjectVariableEnum.var_770, object.getModelController().getNumber(RoomObjectVariableEnum.var_770), parseInt(_loc13_));
                                        break;
                                    case var_1060:
                                        _loc1_ = this.updateOffset(RoomObjectVariableEnum.var_771, object.getModelController().getNumber(RoomObjectVariableEnum.var_771), parseInt(_loc13_));
                                        break;
                                    case var_1061:
                                        _loc1_ = this.updateOffset(RoomObjectVariableEnum.var_772, object.getModelController().getNumber(RoomObjectVariableEnum.var_772), parseInt(_loc13_));
                                        break;
                                };
                            };
                        };
                    };
                    _loc4_ = object.getModelController().getString(RoomObjectVariableEnum.var_769);
                    _loc5_ = object.getModelController().getString(RoomObjectVariableEnum.FURNITURE_BRANDING_CLICK_URL);
                    _loc6_ = object.getModelController().getNumber(RoomObjectVariableEnum.var_770);
                    _loc7_ = object.getModelController().getNumber(RoomObjectVariableEnum.var_771);
                    _loc8_ = object.getModelController().getNumber(RoomObjectVariableEnum.var_772);
                    if (_loc4_ != null)
                    {
                        eventDispatcher.dispatchEvent(new RoomObjectRoomAdEvent(RoomObjectRoomAdEvent.var_319, object.getId(), object.getType(), _loc4_, _loc5_));
                    };
                    _loc9_ = (((var_1057 + "=") + ((_loc4_ != null) ? _loc4_ : "")) + "\t");
                    if (this.var_4523)
                    {
                        _loc9_ = (_loc9_ + (((var_1058 + "=") + ((_loc5_ != null) ? _loc5_ : "")) + "\t"));
                    };
                    _loc9_ = (_loc9_ + (((var_1059 + "=") + _loc6_) + "\t"));
                    _loc9_ = (_loc9_ + (((var_1060 + "=") + _loc7_) + "\t"));
                    _loc9_ = (_loc9_ + (((var_1061 + "=") + _loc8_) + "\t"));
                    object.getModelController().setString(RoomWidgetInfostandExtraParamEnum.var_1062, (RoomWidgetInfostandExtraParamEnum.var_1063 + _loc9_));
                };
            };
            return (_loc1_);
        }

        private function updateOffset(param1:String, param2:int, param3:int):Boolean
        {
            if (param2 != param3)
            {
                object.getModelController().setNumber(param1, param3);
                return (true);
            };
            return (false);
        }


    }
}